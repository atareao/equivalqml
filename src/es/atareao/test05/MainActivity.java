package es.atareao.test05;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;

import es.atareao.test05.R;

import android.os.Bundle;
import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemSelectedListener;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;

public class MainActivity extends Activity {
	public static final String EQUIVAL_CONFIGURATION_NAME = "EquivalConfiguration";
	private EditText value_from;
	private EditText value_to;
	private Spinner magnitudes;
	private Spinner unit_from;
	private Spinner unit_to;
	private Button button_clear;
				
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		magnitudes = (Spinner) findViewById(R.id.spinner1);
		unit_from = (Spinner)findViewById(R.id.unit_from);
		unit_to = (Spinner)findViewById(R.id.unit_to);		
		value_from = (EditText)findViewById(R.id.value_from);		
		value_to  = (EditText)findViewById(R.id.value_to);
		button_clear = (Button)findViewById(R.id.button_clear);
		button_clear.setOnClickListener(new OnClickListener(){
			@Override
			public void onClick(View v) {
				value_from.setText("0.0");
				convert_to();
				
			}
			
		});
		List<String> SpinnerArray = this.get_magnitudes();
	    ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, SpinnerArray);
	    adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);	    
	    magnitudes.setAdapter(adapter); 
		// Restore preferences
	    SharedPreferences settings = getSharedPreferences(EQUIVAL_CONFIGURATION_NAME, 0);
	    int magnitud_id = settings.getInt("magnitud_id", 0);
	    int unit_from_id = settings.getInt("unit_from_id", 0);
	    int unit_to_id = settings.getInt("unit_to_id", 0);	    
	    magnitudes.setSelection(magnitud_id);
	    unit_from.setSelection(unit_from_id);
	    unit_to.setSelection(unit_to_id);
	    /*convert();*/
	    magnitudes.setOnItemSelectedListener(new OnItemSelectedListener(){
			@Override
			public void onItemSelected(AdapterView<?> arg0, View arg1,
					int arg2, long arg3) {
				// TODO Auto-generated method stub
				String fu = String.valueOf(magnitudes.getSelectedItem());
				set_values_on_spinner(fu);
			    SharedPreferences settings = getSharedPreferences(EQUIVAL_CONFIGURATION_NAME, 0);
			    int magnitud_id = settings.getInt("magnitud_id", 0);
			    int unit_from_id = settings.getInt("unit_from_id", 0);
			    int unit_to_id = settings.getInt("unit_to_id", 0);	    
			    if(magnitudes.getSelectedItemPosition() == magnitud_id){
				    unit_from.setSelection(unit_from_id);
				    unit_to.setSelection(unit_to_id);			    	
			    }				
				convert_from();
			}

			@Override
			public void onNothingSelected(AdapterView<?> arg0) {
				// TODO Auto-generated method stub
				
			}
	    	
	    });
		value_from.addTextChangedListener(new TextWatcher(){

			@Override
			public void afterTextChanged(Editable s) {
				// TODO Auto-generated method stub
			}

			@Override
			public void beforeTextChanged(CharSequence s, int start, int count,
					int after) {
				// TODO Auto-generated method stub
				
			}

			@Override
			public void onTextChanged(CharSequence s, int start, int before,
					int count) {				
				if(value_from.hasFocus()||unit_from.hasFocus()){
					convert_to();
				}
			}
			
		});
		
		value_from.setOnFocusChangeListener(new View.OnFocusChangeListener() {
		    @Override
		    public void onFocusChange(View v, boolean hasFocus) {
		        if (hasFocus) {
		            getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_VISIBLE);
		        }
		    }
		});
		value_from.postDelayed(new Runnable() {
			  @Override
			  public void run() {
			    // TODO Auto-generated method stub
			    InputMethodManager keyboard = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
			    keyboard.showSoftInput(value_from, 0);
			  }
			},50);				
		value_to.addTextChangedListener(new TextWatcher(){

			@Override
			public void afterTextChanged(Editable s) {
				// TODO Auto-generated method stub
			}

			@Override
			public void beforeTextChanged(CharSequence s, int start, int count,
					int after) {
				// TODO Auto-generated method stub
				
			}

			@Override
			public void onTextChanged(CharSequence s, int start, int before,
					int count) {
				// TODO Auto-generated method stub				
				if(value_to.hasFocus()||unit_to.hasFocus()){
					convert_from();
				}
			}
			
		});
		value_to.setOnFocusChangeListener(new View.OnFocusChangeListener() {
		    @Override
		    public void onFocusChange(View v, boolean hasFocus) {
		        if (hasFocus) {
		            getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_VISIBLE);
		        }
		    }
		});		
		unit_from.setOnItemSelectedListener(new OnItemSelectedListener(){

			@Override
			public void onItemSelected(AdapterView<?> arg0, View arg1,
					int arg2, long arg3) {
				// TODO Auto-generated method stub				
				if(value_to.hasFocus()||value_from.hasFocus()){
					convert_to();
				}
			}

			@Override
			public void onNothingSelected(AdapterView<?> arg0) {
				// TODO Auto-generated method stub
				
			}
	    	
	    });
		unit_to.setOnItemSelectedListener(new OnItemSelectedListener(){

			@Override
			public void onItemSelected(AdapterView<?> arg0, View arg1,
					int arg2, long arg3) {
				// TODO Auto-generated method stub				
				if(value_to.hasFocus()||value_from.hasFocus()){
					convert_from();
				}
			}

			@Override
			public void onNothingSelected(AdapterView<?> arg0) {
				// TODO Auto-generated method stub
				
			}
	    	
	    });
		/*
		Button convertButton = (Button) findViewById(R.id.button_convert);
		convertButton.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				convert_to();			
				String fu = String.valueOf(unit_from.getSelectedItem());
				String tu = String.valueOf(unit_to.getSelectedItem());
				if(fu=="ºC"){
					if(tu=="ºF"){
						tv = 9.0/5.0*fv+32.0;
					}else if(tu=="K"){
						tv = fv+273.15;
					}else if(tu=="ºR"){
						tv = (fv+273.15)*9.0/5.0;
					}else{
						tv = fv;
					}
				}else if(fu=="ºF"){
					if(tu=="ºC"){
						tv = (fv-32.0)*5.0/9.0;
					}else if(tu=="K"){
						tv = (fv-32.0)*5.0/9.0+273.15;
					}else if(tu=="ºR"){
						tv = fv-32.0+(273.15)*9.0/5.0;
					}else{
						tv = fv;
					}
				}else if(fu=="K"){
						if(tu=="ºC"){
							tv = fv-273.15;
						}else if(tu=="ºF"){
							tv = 9.0/5.0*(fv-273.15)+32.0;
						}else if(tu=="ºR"){
							tv = (fv)*9.0/5.0;
						}else{
							tv = fv;
						}			
				}else if(fu=="R"){
					if(tu=="ºC"){
						tv = 5.0/9.0*fv-273.15;
					}else if(tu=="ºF"){
						tv = fv+32.0-(273.15)*9.0/5.0;
					}else if(tu=="K"){
						tv = (fv)*5.0/9.0;
					}else{
						tv = fv;
					}
				}
				value_to.setText(Double.toString(tv));
			
			}
		});
		*/
	}

	@Override
    protected void onStop(){
		super.onStop();
		// We need an Editor object to make preference changes.
		// All objects are from android.context.Context
		SharedPreferences settings = getSharedPreferences(EQUIVAL_CONFIGURATION_NAME, 0);
		SharedPreferences.Editor editor = settings.edit();
		editor.putInt("magnitud_id",magnitudes.getSelectedItemPosition());
		editor.putInt("unit_from_id",unit_from.getSelectedItemPosition());
		editor.putInt("unit_to_id",unit_to.getSelectedItemPosition());
		// Commit the edits!
		editor.commit();
	}
	
	public double convert2double(String cadena){
		if(cadena == ""){
			return 0.0;
		}
		try{
			return Double.valueOf(cadena).doubleValue();
		}catch (NumberFormatException e) {
			return 0.0;
		}
	}
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.activity_main, menu);
		return true;
	}
	public void set_values_on_spinner(String magnitud){
		List<Unit> SpinnerArray = this.get_unidades(magnitud);
	    ArrayAdapter<Unit> adapter = new ArrayAdapter<Unit>(this, android.R.layout.simple_spinner_item, SpinnerArray);
	    adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
	    unit_from.setAdapter(adapter);		
	    unit_to.setAdapter(adapter);
	}
	public void convert_to(){
		try{
			Unit fu = (Unit)unit_from.getSelectedItem();
			Unit tu = (Unit)unit_to.getSelectedItem();
			double fv = convert2double(value_from.getText().toString());
			double tv = 0.0;
			tv = fv*fu.getFactor()/tu.getFactor();
			value_to.setText(Double.toString(tv));
		}catch (java.lang.NullPointerException e){
			value_to.setText("0.0");				
		}
	}
	public void convert_from(){
		try{
			Unit fu = (Unit)unit_from.getSelectedItem();
			Unit tu = (Unit)unit_to.getSelectedItem();
			double fv = 0.0;
			double tv = convert2double(value_to.getText().toString());
			fv = tv*tu.getFactor()/fu.getFactor();
			value_from.setText(Double.toString(fv));
		}catch (java.lang.NullPointerException e){
			value_from.setText("0.0");
		}
	}
	public List<Unit> get_unidades(String magnitud){
		List<Unit> SpinnerArray =  new ArrayList<Unit>();
		InputStream is = getResources().openRawResource(R.raw.equival);
		Writer writer = new StringWriter();
		char[] buffer = new char[1024];
		try {
		    Reader reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		    int n;
		    while ((n = reader.read(buffer)) != -1) {
		        writer.write(buffer, 0, n);
		    }
			String jsonString = writer.toString();
			JSONObject myjson = new JSONObject(jsonString);
			JSONObject mg = myjson.getJSONObject("magnitudes").getJSONObject(magnitud);			
			Iterator<?> iterator = mg.getJSONObject("unidades").keys();
			SpinnerArray =  new ArrayList<Unit>();
			while(iterator.hasNext()){
				String asimbolo = (String)iterator.next();
				JSONObject mu = mg.getJSONObject("unidades").getJSONObject(asimbolo);
				String anombre = (String)mu.getString("nombre");
				double afactor = mu.getDouble("factor");
				Unit aunit = new Unit(asimbolo,anombre,afactor);
				SpinnerArray.add(aunit);
			}
			Collections.sort(SpinnerArray);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
		    try {
				is.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return SpinnerArray;
	}
	private List<String> get_magnitudes(){
		List<String> SpinnerArray =  new ArrayList<String>();
		InputStream is = getResources().openRawResource(R.raw.equival);
		Writer writer = new StringWriter();
		char[] buffer = new char[1024];
		try {
		    Reader reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		    int n;
		    while ((n = reader.read(buffer)) != -1) {
		        writer.write(buffer, 0, n);
		    }
			String jsonString = writer.toString();
			JSONObject myjson = new JSONObject(jsonString);
			JSONObject mg = myjson.getJSONObject("magnitudes");
			Iterator<?> iterator = mg.keys();
			SpinnerArray =  new ArrayList<String>();
			while(iterator.hasNext()){
				SpinnerArray.add((String) iterator.next());
			}
			Collections.sort(SpinnerArray);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
		    try {
				is.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return SpinnerArray;
	}
 
}

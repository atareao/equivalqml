package es.atareao.test05;

public class Unit implements Comparable<Unit> {
	private String simbolo;
	private String nombre;
	private double factor;
	public Unit(String simbolo, String nombre, double factor){
		this.setSimbolo(simbolo);
		this.setNombre(nombre);
		this.setFactor(factor);
	}
	public String getSimbolo() {
		return simbolo;
	}
	public void setSimbolo(String simbolo) {
		this.simbolo = simbolo;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public double getFactor() {
		return factor;
	}
	public void setFactor(double factor) {
		this.factor = factor;
	}
	@Override
	public int compareTo(Unit another) {
		return this.getSimbolo().compareToIgnoreCase(another.getSimbolo());
	}
	@Override
	public String toString(){
		return this.getSimbolo();
	}
	@Override
	public boolean equals(Object object){
		Unit aunit = (Unit)object;
		return aunit.getSimbolo().equals(this.getSimbolo());
	}

}

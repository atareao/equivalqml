function load(listModel,theunits, selectorfrom,selectorto) {

    listModel.clear();
    var xhr = new XMLHttpRequest();
    xhr.open("GET","equival",true);
    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE)
        {
            var jsonObject = JSON.parse(xhr.responseText);
            var keys=new Array();
            for (var key in jsonObject.magnitudes) {
                keys.push([key.toLowerCase(),jsonObject.magnitudes[key]['nombre'].toLowerCase(),jsonObject.magnitudes[key]['unidades']]);
            };
            keys.sort();
            for (var index in keys) {
                listModel.append({
                                     "key" : keys[index][0],
                                     "nombre" : keys[index][1],
                                     "unidades" : keys[index][2]
                });
            }
            loadUnits(theunits,keys[0][2],selectorfrom,selectorto)

        }
    }
    xhr.send();
}
function loadUnits(listModel,unidades,selectorfrom,selectorto) {
    listModel.clear();
    var keys=new Array();
    for (var key in unidades) {
        keys.push([key.toLowerCase(),unidades[key]['factor']]);
    };
    keys.sort();
    for (var index in keys) {
        listModel.append({
                             "key" : keys[index][0],
                             "factor" : keys[index][1]
        });
    };
    selectorfrom.text = keys[0][0];
    selectorto.text = keys[0][0];
}

pragma solidity >=0.4.22 <0.7.0;


contract PredispitneObaveze {
    
    string public nazivPredmeta;
     
    // rok za prvi zadatak  Friday, May 1, 2020 0:00:00 
    uint256 rokZaPrviZadatak = 1588291200;
    
     // rok za drugi zadatak  Friday, May 15, 2020 0:00:00 
    uint256 rokZaDrugiZadatak = 1589500800;
    
     // rok za treci zadatak  Saturday, May 30, 2020 0:00:00 
    uint256 rokZaTreciZadatak = 1590796800;
    
    
    struct ResenjeZadatka {
        uint id;
        address predao;     // adresa ko je predao zacatak
        string sadrzaj;     // sadrzaj fajla recimo base64 ili putanja do fajla
        uint256 vremePredavanja;     // vreme kada je predat zadatak
    }
    
    // brojaci predatih resenja
    uint public brojPredatihResenjeZaPrviZadatak = 0;
    uint public brojPredatihResenjeZaDrugiZadatak = 0;
    uint public brojPredatihResenjeZaTreciZadatak = 0;
    
    // predata resenja
    mapping(uint => ResenjeZadatka) public resenjaPrvogZadatka;
    mapping(uint => ResenjeZadatka) public resenjaDrugogZadatka;
    mapping(uint => ResenjeZadatka) public resenjaTrecegZadatka;
    
    // definisem event da javim da je predat zadatak
    event PredatoResenje(string brojZadatka, uint idZadatka, address predao);
    
    // provera da li je prosao rok za predaju resenja
    modifier dokTrajeRokZaPrvi() {
        require(block.timestamp <= rokZaPrviZadatak);
        _;
    }

    modifier dokTrajeRokZaDrugi() {
        require(block.timestamp <= rokZaDrugiZadatak);
        _;
    }
    
    modifier dokTrajeRokZaTreci() {
        require(block.timestamp <= rokZaTreciZadatak);
        _;
    }
    
  
    constructor() public {
        nazivPredmeta = "Bioloski inspirisano racunarstvo";
    }
    

    // funkcija za predavanje resenja za prvi zadatak
    function predajResenjeZaPrviZadatak(string memory resenje, uint256 predato) public dokTrajeRokZaPrvi {
        // resenje ne moze biti prazno
        require(bytes(resenje).length > 0);
        
        // da li je istekao rok za predaju zadatka
        // require(now <= rokZaPrviZadatak);
        
        bool predao = false;
        for(uint i=0; i <= brojPredatihResenjeZaPrviZadatak; i++) {
            if (resenjaPrvogZadatka[i].predao == msg.sender) {
                predao = true;
            }
        }
        
        require(predao == false);
        
    
        brojPredatihResenjeZaPrviZadatak ++;
        resenjaPrvogZadatka[brojPredatihResenjeZaPrviZadatak] = ResenjeZadatka(brojPredatihResenjeZaPrviZadatak, msg.sender, resenje, predato);
        
        // javljam da je predato resenje
        emit PredatoResenje("Prvi zadatak", brojPredatihResenjeZaPrviZadatak, msg.sender);
    }
    
     // funkcija za predavanje resenja za drugi zadatak
    function predajResenjeZaDrugiZadatak(string memory resenje, uint256 predato) public dokTrajeRokZaDrugi {
        // resenje ne moze biti prazno
        require(bytes(resenje).length > 0);
        
        // da li je istekao rok za predaju zadatka
        // require(now <= rokZaDrugiZadatak);
        
        bool predao = false;
        for(uint i=0; i <= brojPredatihResenjeZaDrugiZadatak; i++) {
            if (resenjaDrugogZadatka[i].predao == msg.sender) {
                predao = true;
            }
        }
        
        require(predao == false);
        
    
        brojPredatihResenjeZaDrugiZadatak ++;
        resenjaDrugogZadatka[brojPredatihResenjeZaDrugiZadatak] = ResenjeZadatka(brojPredatihResenjeZaDrugiZadatak, msg.sender, resenje, predato);
        
        // javljam da je predato resenje
        emit PredatoResenje("Drugi zadatak", brojPredatihResenjeZaDrugiZadatak, msg.sender);
    }
    
     // funkcija za predavanje resenja za drugi zadatak
    function predajResenjeZaTreciZadatak(string memory resenje, uint256 predato) public dokTrajeRokZaTreci {
        // resenje ne moze biti prazno
        require(bytes(resenje).length > 0);
        
        // da l ije vec predat
        bool predao = false;
        for(uint i=0; i <= brojPredatihResenjeZaTreciZadatak; i++) {
            if (resenjaTrecegZadatka[i].predao == msg.sender) {
                predao = true;
            }
        }
        
        require(predao == false);
        
        brojPredatihResenjeZaTreciZadatak ++;
        resenjaTrecegZadatka[brojPredatihResenjeZaTreciZadatak] = ResenjeZadatka(brojPredatihResenjeZaTreciZadatak, msg.sender, resenje, predato);
        
        // javljam da je predato resenje
        emit PredatoResenje("Trece zadatak", brojPredatihResenjeZaTreciZadatak, msg.sender);
    }

}
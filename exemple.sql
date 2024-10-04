drop procedure if exists ps_not_found;
delimiter $$
create procedure ps_not_found(in p_nom varchar(200))
begin
   declare flagNOTFOUND boolean default false;
   declare client_nom varchar(200);

   declare exit handler for not found
    begin
        set flagNOTFOUND := true;
    end;
    select nom into client_nom
    from clients
    where nom = p_nom;

   if flagNOTFOUND = false then
        select CONCAT('Le client trouvé avec le nom "', p_nom, '" est : ', client_nom) 
        as 'Resultat';
	else
        select CONCAT('Aucun client trouvé avec le nom "', p_nom, '".')
        as 'Resultat';
    end if;
end$$
DELIMITER ;

call ps_not_found('Dupont');

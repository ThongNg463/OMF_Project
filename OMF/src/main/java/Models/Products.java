    /*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
     */
    package Models;

    /**
     *
     * @author mthon
     */
    public class Products {
        private String ProID;
        private int ProStock;
        private String ProName;
        private String ProPic;
        private String ProDes;
        private String ProPrice;
        private String ProType;

        public Products() {
        }

        public Products(String ProID, int ProStock, String ProName, String ProPic, String ProDes, String ProPrice, String ProType) {
            this.ProID = ProID;
            this.ProStock = ProStock;
            this.ProName = ProName;
            this.ProPic = ProPic;
            this.ProDes = ProDes;
            this.ProPrice = ProPrice;
            this.ProType = ProType;
        }

        public String getProID() {
            return ProID;
        }

        public void setProID(String ProID) {
            this.ProID = ProID;
        }

        public int getProStock() {
            return ProStock;
        }

        public void setProStock(int ProStock) {
            this.ProStock = ProStock;
        }

        public String getProName() {
            return ProName;
        }

        public void setProName(String ProName) {
            this.ProName = ProName;
        }

        public String getProPic() {
            return ProPic;
        }

        public void setProPic(String ProPic) {
            this.ProPic = ProPic;
        }

        public String getProDes() {
            return ProDes;
        }

        public void setProDes(String ProDes) {
            this.ProDes = ProDes;
        }

        public String getProPrice() {
            return ProPrice;
        }

        public void setProPrice(String ProPrice) {
            this.ProPrice = ProPrice;
        }

        public String getProType() {
            return ProType;
        }

        public void setProType(String ProType) {
            this.ProType = ProType;
        }


    }

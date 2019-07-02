Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9165C992
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jul 2019 08:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfGBGva (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Jul 2019 02:51:30 -0400
Received: from mail-eopbgr1320048.outbound.protection.outlook.com ([40.107.132.48]:58848
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725822AbfGBGva (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 2 Jul 2019 02:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector1-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdNCTY/Hr4WWtmrCAeQWVAldCoWunuweT4tTzFFVzAM=;
 b=BkF4IFQ7T3s4AmwhuL193GOPZbGq4YWgl+ePnJtBJ1plFbNrNldabF5rsPrYz+AUr/wsRMLqPjVMTxfEG23GpYhJclcTP9ORLC+xntZUbxGl+jTpce7lwrViOD5QNFJzj6A0GsrwKy4IkZg5esXPbsgoj2H2fqiA+wK/ZsPB76c=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB3469.apcprd01.prod.exchangelabs.com (52.132.233.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Tue, 2 Jul 2019 06:51:24 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::d503:3d71:ce06:19d2]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::d503:3d71:ce06:19d2%6]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 06:51:24 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Linux on UEFI: A Quick Installation Guide
Thread-Topic: Linux on UEFI: A Quick Installation Guide
Thread-Index: AdUwomNM8c0pO3yFRlegeKWsBxCwBA==
Date:   Tue, 2 Jul 2019 06:51:24 +0000
Message-ID: <SG2PR01MB21414474595BCCAB3AD1B07F87F80@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1eff94a5-c0cc-4bbc-5cc3-08d6feb9b305
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SG2PR01MB3469;
x-ms-traffictypediagnostic: SG2PR01MB3469:
x-ms-exchange-purlcount: 5
x-microsoft-antispam-prvs: <SG2PR01MB3469192F483E15D2583BA86387F80@SG2PR01MB3469.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(39830400003)(396003)(346002)(199004)(189003)(99286004)(508600001)(6116002)(2351001)(66446008)(66476007)(66556008)(3846002)(66066001)(64756008)(76116006)(73956011)(66946007)(102836004)(256004)(68736007)(74316002)(305945005)(26005)(71200400001)(71190400001)(486006)(7696005)(6506007)(25786009)(2501003)(86362001)(4326008)(6436002)(53936002)(476003)(316002)(81166006)(81156014)(8676002)(966005)(33656002)(2906002)(14454004)(107886003)(52536014)(5660300002)(4744005)(5640700003)(6916009)(55016002)(186003)(6306002)(9686003)(7736002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB3469;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XUP5tIZxJ0rVEz/TN5RCYbVRmYZth+FxjbtqjE/CrKRZYJzy9NAlYGa/68LN8BTKH2LFSDXxOtzEitPU04nzMi+wUd6pi8A4zf7UwbXbN9b3B0zoACTqopI8b1zxA2P3PSsz4Xa8LoOoeOfC8DRlMuoSX6Js8jMueTxWmx5aX/egDG38/7mQy4cY4odLP08pvvZog8N5M7ti9+rY6auA5/ejj1MAsWiWSswy/FHgdRqqqo0ULqdlewNY1MBMnKr7JTWOACnYdRAR2L0wqI38icXcUcZt105YJaDZUXU1eFrWsmNontW8W5NLvO/1Yhd8NqErL7YijJjp9EU3urRhdz1Lq5nkfgnavkWfchwmfMM4IDaUyNr8iYx7Uz7SblBuruhyNlFBhVcapuVkLZrdua27aroSEg8ypzabx+8GQXI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eff94a5-c0cc-4bbc-5cc3-08d6feb9b305
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 06:51:24.4542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ceo@teo-en-ming-corp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3469
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Good afternoon from Singapore,

Article: Linux on UEFI: A Quick Installation Guide
Author: Roderick W. Smith, rodsmith@rodsbooks.com
Link: http://www.rodsbooks.com/linux-uefi/

Thank you.




-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwav=
e.html

***************************************************************************=
*****************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----


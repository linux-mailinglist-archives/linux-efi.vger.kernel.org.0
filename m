Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF2111E214
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2019 11:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfLMKgx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Fri, 13 Dec 2019 05:36:53 -0500
Received: from m4a0073g.houston.softwaregrp.com ([15.124.2.131]:42101 "EHLO
        m4a0073g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725747AbfLMKgw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Dec 2019 05:36:52 -0500
Received: FROM m4a0073g.houston.softwaregrp.com (15.120.17.147) BY m4a0073g.houston.softwaregrp.com WITH ESMTP;
 Fri, 13 Dec 2019 10:34:46 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 13 Dec 2019 10:35:03 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (15.124.8.14) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 13 Dec 2019 10:35:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lla6KRrLUBafguKdhhiyEfjRuSWXqHnarY1bdOqOuugc1FIc7kltrGzOfe9AhODNKybPiMBE89DGklZx6qsZMzhme31qkQieTL2MSz9rD3r++M6iSKWI+7+ODR36+4CE4enjaVb9BUpcxmHSyEUL1Sdabwtt6yr2pMRqA/OgstFOyt/U866eq5bv8xw04VoFL877wSIioIkVxlLOi6pE769lcQGqIvi3KpcgjhuRRxnHgecJXwpRhlOUAH1yGxflEp02uKKZLD8/khgTsrj3p3fsTPnJMxsaZBbmpVpgZUvbJoXsOZvss2VRzqnMyFewA4OTXiLnvKPsAmWNLdok+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdkR3e3gS9wOAYhqvSivnmiO4uc5uIqt6bDyuVI0X44=;
 b=mwFwU3r21dKzQJlC2VvLWKBsF4Ee2CQJM8JRJpin7slMllV+IthQyN3nVZoCe8SUchxzjHUJ1kYCpEtvQdGe4oPTdZJ7SlIY8LghLpOQm3Vk891mzC69wOnAKjdR6G/Oq9pjg3wbHdWXnWbOug84SYQCZP/8tat47iZ3ICXnfQxF7kpkO+7wKWQm0yzWK9m6MWFxLUK13pJSfmM5208CTBwXu2auoIKy2362U0phbIROs0RT4Akz1IZmEnID7k5IgKIWd1nIYt4I39tExO+a8ZmwarUz8Tz66pRTOJA+4wk1bX+Xp0EpaSuoBpZvwFnUtBPlofaqKus22if2JNEirA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from MWHPR1801MB1919.namprd18.prod.outlook.com (10.164.204.162) by
 MWHPR1801MB1917.namprd18.prod.outlook.com (10.164.204.160) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Fri, 13 Dec 2019 10:35:01 +0000
Received: from MWHPR1801MB1919.namprd18.prod.outlook.com
 ([fe80::1c16:ffc:c341:ebbc]) by MWHPR1801MB1919.namprd18.prod.outlook.com
 ([fe80::1c16:ffc:c341:ebbc%6]) with mapi id 15.20.2538.016; Fri, 13 Dec 2019
 10:35:01 +0000
From:   Joey Lee <JLee@suse.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Chun-Yi Lee <joeyli.kernel@gmail.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        "Nayna Jain" <nayna@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 2/2] efi: show error messages only when loading
 certificates is failed
Thread-Topic: [PATCH 2/2] efi: show error messages only when loading
 certificates is failed
Thread-Index: AQHVsZU0Eap8mezu6UCH9Ab36BcR6ae3ygyAgAAMIgCAAAiJgA==
Date:   Fri, 13 Dec 2019 10:35:01 +0000
Message-ID: <20191213103447.GA22409@linux-l9pv.suse>
References: <20191213090646.12329-1-jlee@suse.com>
 <20191213090646.12329-3-jlee@suse.com>
 <CAKv+Gu_2GTqKJNVpMEg4ic_3ACb5GJKAkgfFWoEdWqMN7pmwiA@mail.gmail.com>
 <20191213092049.GW22409@linux-l9pv.suse>
 <CAKv+Gu8-Ay2R9wU-wwz2w+Q9jZOduXYigmFJL8Rmppnm1CSpHg@mail.gmail.com>
In-Reply-To: <CAKv+Gu8-Ay2R9wU-wwz2w+Q9jZOduXYigmFJL8Rmppnm1CSpHg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2P15301CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::34) To MWHPR1801MB1919.namprd18.prod.outlook.com
 (2603:10b6:301:68::34)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=JLee@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [60.251.47.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77ac7a76-33df-4d8f-152f-08d77fb81be2
x-ms-traffictypediagnostic: MWHPR1801MB1917:
x-microsoft-antispam-prvs: <MWHPR1801MB19175EC49A1DAED5F4DBAEDCA3540@MWHPR1801MB1917.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:83;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(199004)(189003)(8676002)(4326008)(54906003)(81156014)(36756003)(81166006)(316002)(7416002)(86362001)(2906002)(8936002)(6916009)(52116002)(71200400001)(478600001)(6486002)(5660300002)(15650500001)(66446008)(186003)(33656002)(64756008)(66946007)(26005)(1076003)(6506007)(66476007)(55236004)(6512007)(66556008)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1801MB1917;H:MWHPR1801MB1919.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E/6/e4Moywqpd0jWfZJgN50R42NDRXGusET3YDQeZ9iSePglTAGFM5FbQe32DOoGZourenrYKdMtOY3Fe0msNqTgvMMy+p0K5K0SSdMzjSDjyVBdbFiZJxnJqpSRThL0GKFJ+VVWsjk01k9DygW8FXPLgcbJSxCzYLnNazafJ9dcs/EdFVUMnDXj3vt1lwoAuhUxlUJ8P45W+xObI009D2Kv8grp3zFFTE5lnIzbICHdfqfYZsglvPTzzp9gXHZS34GJ28iYFcRjN/GMWMVDgUWAapc3gNvucMO4fIiyKnpaxyw0yxjE+eXiUBcNbCVUo7UM/r2OCfA5wz8Zto91oEi19ehMsss87HbGpe/MveIGC0Dd1C4rfHomWOAIvcuk0ViQrl19suKY1ilRXDIunSM6gFVqNAJ1WLosu3ldpXmRWMGMlIwgCe/L0hsrpc5x
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <38B02C5CBD33F7479AEDCA36FDB26E30@namprd18.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ac7a76-33df-4d8f-152f-08d77fb81be2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 10:35:01.5645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JGnCUGMyyz7tpq3ZSoEVMPR8JobOFY5HZpckqZZysHXB39C4b3CWXimPJLRwwEu6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB1917
X-OriginatorOrg: suse.com
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Fri, Dec 13, 2019 at 10:04:14AM +0000, Ard Biesheuvel wrote:
> On Fri, 13 Dec 2019 at 10:21, Joey Lee <JLee@suse.com> wrote:
> >
> > Hi Ard,
> >
> > On Fri, Dec 13, 2019 at 09:10:12AM +0000, Ard Biesheuvel wrote:
> > > On Fri, 13 Dec 2019 at 10:07, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> > > >
> > > > When loading certificates list from EFI variables, the error
> > > > message and efi status code always be emitted to dmesg. It looks
> > > > ugly:
> > > >
> > > > [    2.335031] Couldn't get size: 0x800000000000000e
> > > > [    2.335032] Couldn't get UEFI MokListRT
> > > > [    2.339985] Couldn't get size: 0x800000000000000e
> > > > [    2.339987] Couldn't get UEFI dbx list
> > > >
> > > > This cosmetic patch moved the messages to the error handling code
> > > > path. And, it also shows the corresponding status string of status
> > > > code.
> > > >
> > >
> > > So what output do we get after applying this patch when those
> > > variables don't exist?
> > >
> >
> > A "UEFI:xxxx list was not found" message will be exposed in dmesg
> > when kernel loglevel be set to debug. Otherwise there have no messages.
> >
> 
> OK, that works for me.
> 
> I take it this will go via the linux-security tree along with 1/2?
>

Yes, this patch must go with 1/2 patch. 
 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> 

Thanks for your review!

Joey Lee
> 
> 
> > > > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> > > > ---
> > > >  security/integrity/platform_certs/load_uefi.c | 40 ++++++++++++++-------------
> > > >  1 file changed, 21 insertions(+), 19 deletions(-)
> > > >
> > > > diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> > > > index 81b19c52832b..b6c60fb3fb6c 100644
> > > > --- a/security/integrity/platform_certs/load_uefi.c
> > > > +++ b/security/integrity/platform_certs/load_uefi.c
> > > > @@ -1,4 +1,5 @@
> > > >  // SPDX-License-Identifier: GPL-2.0
> > > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > >
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/sched.h>
> > > > @@ -39,7 +40,7 @@ static __init bool uefi_check_ignore_db(void)
> > > >   * Get a certificate list blob from the named EFI variable.
> > > >   */
> > > >  static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
> > > > -                                 unsigned long *size)
> > > > +                                 unsigned long *size, const char *source)
> > > >  {
> > > >         efi_status_t status;
> > > >         unsigned long lsize = 4;
> > > > @@ -48,23 +49,30 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
> > > >
> > > >         status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
> > > >         if (status != EFI_BUFFER_TOO_SMALL) {
> > > > -               pr_err("Couldn't get size: 0x%lx\n", status);
> > > > -               return NULL;
> > > > +               if (status == EFI_NOT_FOUND) {
> > > > +                       pr_debug("%s list was not found\n", source);
> > > > +                       return NULL;
> > > > +               }
> > > > +               goto err;
> > > >         }
> > > >
> > > >         db = kmalloc(lsize, GFP_KERNEL);
> > > > -       if (!db)
> > > > -               return NULL;
> > > > +       if (!db) {
> > > > +               status = EFI_OUT_OF_RESOURCES;
> > > > +               goto err;
> > > > +       }
> > > >
> > > >         status = efi.get_variable(name, guid, NULL, &lsize, db);
> > > >         if (status != EFI_SUCCESS) {
> > > >                 kfree(db);
> > > > -               pr_err("Error reading db var: 0x%lx\n", status);
> > > > -               return NULL;
> > > > +               goto err;
> > > >         }
> > > >
> > > >         *size = lsize;
> > > >         return db;
> > > > +err:
> > > > +       pr_err("Couldn't get %s list: %s\n", source, efi_status_to_str(status));
> > > > +       return NULL;
> > > >  }
> > > >
> > > >  /*
> > > > @@ -153,10 +161,8 @@ static int __init load_uefi_certs(void)
> > > >          * an error if we can't get them.
> > > >          */
> > > >         if (!uefi_check_ignore_db()) {
> > > > -               db = get_cert_list(L"db", &secure_var, &dbsize);
> > > > -               if (!db) {
> > > > -                       pr_err("MODSIGN: Couldn't get UEFI db list\n");
> > > > -               } else {
> > > > +               db = get_cert_list(L"db", &secure_var, &dbsize, "UEFI:db");
> > > > +               if (db) {
> > > >                         rc = parse_efi_signature_list("UEFI:db",
> > > >                                         db, dbsize, get_handler_for_db);
> > > >                         if (rc)
> > > > @@ -166,10 +172,8 @@ static int __init load_uefi_certs(void)
> > > >                 }
> > > >         }
> > > >
> > > > -       mok = get_cert_list(L"MokListRT", &mok_var, &moksize);
> > > > -       if (!mok) {
> > > > -               pr_info("Couldn't get UEFI MokListRT\n");
> > > > -       } else {
> > > > +       mok = get_cert_list(L"MokListRT", &mok_var, &moksize, "UEFI:MokListRT");
> > > > +       if (mok) {
> > > >                 rc = parse_efi_signature_list("UEFI:MokListRT",
> > > >                                               mok, moksize, get_handler_for_db);
> > > >                 if (rc)
> > > > @@ -177,10 +181,8 @@ static int __init load_uefi_certs(void)
> > > >                 kfree(mok);
> > > >         }
> > > >
> > > > -       dbx = get_cert_list(L"dbx", &secure_var, &dbxsize);
> > > > -       if (!dbx) {
> > > > -               pr_info("Couldn't get UEFI dbx list\n");
> > > > -       } else {
> > > > +       dbx = get_cert_list(L"dbx", &secure_var, &dbxsize, "UEFI:dbx");
> > > > +       if (dbx) {
> > > >                 rc = parse_efi_signature_list("UEFI:dbx",
> > > >                                               dbx, dbxsize,
> > > >                                               get_handler_for_dbx);
> > > > --
> > > > 2.16.4
> > > >

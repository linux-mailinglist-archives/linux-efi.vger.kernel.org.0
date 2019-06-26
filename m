Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D02756870
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jun 2019 14:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfFZMRa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Jun 2019 08:17:30 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:1300 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbfFZMRa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Jun 2019 08:17:30 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QC4uHK014402
        for <linux-efi@vger.kernel.org>; Wed, 26 Jun 2019 08:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=smtpout1;
 bh=vhzu0GCXvnhliSlkm8Xutx3hAOJr07iJJlddcimxJrE=;
 b=DkEVFXyh+Wb9x5J+DzViBsDoePH7A7qCg9y0oyAJi68ET/vxH7MrPWXWVHxErEOINHxU
 tQdDlcGCwWsilmUTlvIoIPYCmmlD1P6kwCQpEwk5Aghi288yh5doB/kNdy7RrnyTMlQm
 60R5uUA+cnogZkcHtwVq6k1nuexwMoS3Na00EYkmDlFWSFjCT6YrFXE/ZWpkG0kXn2cH
 haDlB7zPPP9KXG8lxMKzabKsbcA244FnMikoUNWyacntTwqd9Bms1ktGaxrDhk6adRNP
 2B8WASv3sk1LR//6Y8Havb/MeslKs74AxVwysvyCJyMJzfZOYaimd5olImy2vjPPA1q6 4g== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2tbnsrmdgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Wed, 26 Jun 2019 08:17:28 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QCGtM9170457
        for <linux-efi@vger.kernel.org>; Wed, 26 Jun 2019 08:17:27 -0400
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0a-00154901.pphosted.com with ESMTP id 2tbh6fegbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-efi@vger.kernel.org>; Wed, 26 Jun 2019 08:17:27 -0400
X-LoopCount0: from 10.166.135.92
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="819388055"
From:   <Narendra.K@dell.com>
To:     <ard.biesheuvel@linaro.org>
CC:     <pjones@redhat.com>, <linux-efi@vger.kernel.org>
Subject: Re: [RFC PATCH] Export Runtime Configuration Interface table to sysfs
Thread-Topic: [RFC PATCH] Export Runtime Configuration Interface table to
 sysfs
Thread-Index: AQHVJPURJUa43Zv1v02xbnzCeW3iXaal+J4AgAX/BACAACTUgIABb5YA
Date:   Wed, 26 Jun 2019 12:17:22 +0000
Message-ID: <20190626121712.GA2523@localhost.localdomain>
References: <20190617101134.GA2242@localhost.localdomain>
 <CAKv+Gu_MYJ=EWOphS=dBG8PJqPjG21J9SGrynD2r60SOemttUA@mail.gmail.com>
 <20190625120944.GA4465@localhost.localdomain>
 <CAKv+Gu_cdjU49d5JSJKJ_2Eb2Pp2JY=xe=39J3KyVs7qQnke2g@mail.gmail.com>
In-Reply-To: <CAKv+Gu_cdjU49d5JSJKJ_2Eb2Pp2JY=xe=39J3KyVs7qQnke2g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79847419C91C084686B895514627A2F3@dell.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-26_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906260146
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260146
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 25, 2019 at 04:21:33PM +0200, Ard Biesheuvel wrote:
[...]
> > > > --- a/drivers/firmware/efi/efi.c
> > > > +++ b/drivers/firmware/efi/efi.c
> > > > @@ -53,6 +53,7 @@ struct efi __read_mostly efi =3D {
> > > >         .rng_seed               =3D EFI_INVALID_TABLE_ADDR,
> > > >         .tpm_log                =3D EFI_INVALID_TABLE_ADDR,
> > > >         .mem_reserve            =3D EFI_INVALID_TABLE_ADDR,
> > > > +       .rci2                   =3D EFI_INVALID_TABLE_ADDR,
> > >
> > > Does this really need to live in the efi struct?
> >
> > It probably need not be part of struct efi. We could define a struct of
> > type 'efi_config_table_type_t' in the rci2_table.c. Did you have a
> > similar idea in mind ? If yes, I will modify and test this idea.
> >
>=20
> Yes, I'd like to start keeping these things separate.
>=20
> I pushed a branch here
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=3Dnext
>=20
> that changes the way uv_systab is handled, and moves it into arch/x86.
> Please follow that pattern instead.

Okay. Thank you for the guidance. I will make this change in the next versi=
on.

>=20
> > >
> > > >  };
> > > >  EXPORT_SYMBOL(efi);
> > > >
> > > > @@ -73,6 +74,7 @@ static unsigned long *efi_tables[] =3D {
> > > >         &efi.esrt,
> > > >         &efi.properties_table,
> > > >         &efi.mem_attr_table,
> > > > +       &efi.rci2,
> > > >  };
> > > >
> > >
> > > AFAICT, this table is only used by memremap_is_efi_data() to decide
> > > whether a page should be map as unencrypted, and if the address is in
> > > boot services data or runtime services data, the test will already
> > > success, regardless of whether it appears in this enumeration.
> >
> > Yes. Before 'memremap_is_efi_data()' checks if the memory type is boot
> > services data for runtime services data, it checks if the address is a
> > 'table' address in 'efi_is_table_address'. I added it because of this
> > check. Since the memory type used for the table is efi reserved type, w=
e
> > need to add the table address to 'efi_tables' array so that it could be
> > checked in 'efi_is_table_address'. Please share your thought on this.
> >
>=20
> OK. My branch ^^^ moves this into arch/x86 as well, please add it there

I have a query related to this change. I will discuss it in next section
below as it helps provide complete context.=20

> > > > @@ -488,6 +493,12 @@ static __initdata efi_config_table_type_t comm=
on_tables[] =3D {
> > > >         {NULL_GUID, NULL, NULL},
> > > >  };
> > > >
> > > > +/* OEM Tables */
> > > > +static __initdata efi_config_table_type_t oem_tables[] =3D {
> > > > +       {DELLEMC_EFI_RCI2_TABLE_GUID, "RCI2", &efi.rci2},
> > >
> > > Please drop the string. We don't have to print the presence of this
> > > table in the bootlog since it has no significance to the OS itself.
> >
> > Okay. I will drop this in the next version of the patch.
> >
> > >
> > > > +       {NULL_GUID, NULL, NULL},
> > > > +};
> > > > +
> > >
> > > Do we really need a separate oem_tables[] array?
> >
> > The RCI2 table did not seem to be part of the group of common tables
> > such as SMBIOS and ACPI. To indicate this, I created a separate array.
> > It seems like it is not required. Having the array allows to leverage
> > the table matching code in 'match_config_table' function. Would you pre=
fer
> > to have this entry added to the 'common_tables' array ?
> >
>=20
> Please add it to the arch_tables array in arch/x86 (if my assumption
> is correct that this is x86-only)

The table is used on x86. But it is not specific to x86 and is
independent of the architecture. Because of this detail, my thinking is
to keep the rci2_table.c and related changes in generic efi layer
drivers/firmware/efi/. If we keep the changes in drivers/firmware/efi/,
then two options are=20

1. Retain the oem_tables array and add rci2 table address to this array
2. Add rci2 table address to common_tables array

Does this detail sound correct ?=20

Also, since the 'efi_is_table_address' function and efi_tables array are mo=
ved=20
to arch/x86, for rci2 table address to be detected as a table address, it n=
eeds to be
added to 'efi_tables' array. Would it be correct to add rci2 table
address to this array with rest of the changes residing in the generic efi
layer ?

Please share your thoughts on the two details.=20

[...]
> > Would you prefer to merge this function into 'efi_rci2_sysfs_init' func=
tion ?
> >
>=20
> Yes. Only user space needs to access this, so we can defer this to
> later, when the normal memremap() functions are available.
>=20

Okay, I will make this change in the next version.=20

--=20
With regards,
Narendra K=

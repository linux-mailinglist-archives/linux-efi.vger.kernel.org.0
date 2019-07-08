Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06D2B61E5D
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2019 14:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfGHM0m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Jul 2019 08:26:42 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:7262 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727189AbfGHM0m (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 Jul 2019 08:26:42 -0400
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x68CPCrA001343
        for <linux-efi@vger.kernel.org>; Mon, 8 Jul 2019 08:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=smtpout1;
 bh=qay5X3BLzsT0+Hx1mTxj5FXpzoy7a09c2Dh9mTEtc7g=;
 b=Kt4lthDVHsqxLDru9Xm3zAvHkgQrJdxipW/Ruo599h41QYASWiaDksAJR44Zghi6Pekz
 qt8vcc5SyPUj8xdAn7542Cv+Wb0VFjJvyCnzaVsr4B1twI9SE+m5Ir/v/SniFS4hcAMF
 NKoThmBs2WhQpRYzo3tV5SFAoVeBzVv/fLXdFNZEvosNgQV7DVffnJJIRIc32mNabhB/
 7e2yCz/NsdfiI9ocF3iboVfh9EaYiq4McV2SJXA2xyyuk8Elq5nFLa9UpkeLqsq6uIGW
 V07u++gVDK+XqjYZOxccjq5maq96/rWHBAHNZcJj+n/FZM2tkIqkv3DdZRnDgd6m2DGG Mg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2tjptc7agh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Mon, 08 Jul 2019 08:26:39 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x68CEABe147683
        for <linux-efi@vger.kernel.org>; Mon, 8 Jul 2019 08:26:38 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0a-00154901.pphosted.com with ESMTP id 2tjp9fa73u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-efi@vger.kernel.org>; Mon, 08 Jul 2019 08:26:38 -0400
X-LoopCount0: from 10.166.135.76
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1268075009"
From:   <Narendra.K@dell.com>
To:     <ard.biesheuvel@linaro.org>
CC:     <linux-efi@vger.kernel.org>, <pjones@redhat.com>,
        <Stuart.Hayes@dell.com>, <Narendra.K@dell.com>
Subject: Re: [PATCH v0] Export Runtime Configuration Interface table to sysfs
Thread-Topic: [PATCH v0] Export Runtime Configuration Interface table to sysfs
Thread-Index: AQHVLm0dISGCw1TyVEKadDoZWf9kr6a3Z60AgAjv9AA=
Date:   Mon, 8 Jul 2019 12:26:33 +0000
Message-ID: <20190708122618.GA2085@localhost.localdomain>
References: <20190629112326.GA2366@localhost.localdomain>
 <CAKv+Gu_T-YfsS2pQ202pEMFA+8CbVntTP8CbZTDXLpfaoRg-XQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu_T-YfsS2pQ202pEMFA+8CbVntTP8CbZTDXLpfaoRg-XQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FA3723D8F622594187250DCFF7BE2AF6@dell.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907080154
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907080155
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 02, 2019 at 09:57:24PM +0200, Ard Biesheuvel wrote:
> On Sat, 29 Jun 2019 at 13:23, <Narendra.K@dell.com> wrote:
> >
> > From: Narendra K <Narendra.K@dell.com>
> >
> > System firmware advertises the address of the 'Runtime
> > Configuration Interface table version 2 (RCI2)' via
> > an EFI Configuration Table entry. This code retrieves the RCI2
> > table from the address and exports it to sysfs as a binary
> > attribute 'rci2' under /sys/firmware/efi/tables directory.
> > The approach adopted is similar to the attribute 'DMI' under
> > /sys/firmware/dmi/tables.
> >
> > RCI2 table contains BIOS HII in XML format and is used to populate
> > BIOS setup page in Dell EMC OpenManage Server Administrator tool.
> > The BIOS setup page contains BIOS tokens which can be configured.
> >
> > Signed-off-by: Narendra K <Narendra.K@dell.com>
> > ---
> > RFC -> v0:
> >
> > - Removed rci2 table from struct efi and defined it in rci2_table.c sim=
ilar to
> > the way uv_systab_phys is define in dmesg.
> > - Removed the oem_tables array and added rci2 to common_tables array
> > - Removed the string 'rci2' from the common_tables array so that it is
> > not printed in dmesg.
> > - Merged function 'efi_rci2_table_init' into 'efi_rci2_sysfs_init' func=
tion to
> > avoid calling early_memremap/unmap functions.
> >
> > Also, a note unrelated to this patch - compilation error is observed wh=
en
> > testing with make defconfig related to uv_systab_phys in
> > arch/x86/platform/efi/efi.c. It seems like it needs to be protected wit=
h
> > CONFIG_X86_UV in efi_tables array.
> >
>=20
> Yes, I noticed this as well. This has been fixed now
>=20
> >
> >  Documentation/ABI/testing/sysfs-firmware-efi |   8 +
> >  arch/x86/platform/efi/efi.c                  |   1 +
> >  drivers/firmware/efi/Makefile                |   2 +-
> >  drivers/firmware/efi/efi.c                   |   4 +
> >  drivers/firmware/efi/rci2_table.c            | 147 +++++++++++++++++++
> >  include/linux/efi.h                          |   6 +
> >  6 files changed, 167 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/firmware/efi/rci2_table.c
> >
> > diff --git a/Documentation/ABI/testing/sysfs-firmware-efi b/Documentati=
on/ABI/testing/sysfs-firmware-efi
> > index e794eac32a90..f7822c522a46 100644
> > --- a/Documentation/ABI/testing/sysfs-firmware-efi
> > +++ b/Documentation/ABI/testing/sysfs-firmware-efi
> > @@ -28,3 +28,11 @@ Description: Displays the physical addresses of all =
EFI Configuration
> >                 versions are always printed first, i.e. ACPI20 comes
> >                 before ACPI.
> >  Users:         dmidecode
> > +
> > +What:          /sys/firmware/efi/tables/rci2
> > +Date:          June 2019
> > +Contact:       Narendra K <Narendra.K@dell.com>, linux-bugs@dell.com
> > +Description:   Displays the content of the Runtime Configuration Inter=
face
> > +               Table version 2 on Dell EMC PowerEdge systems in binary=
 format
> > +Users:         It is used by Dell EMC OpenManage Server Administrator =
tool to
> > +               populate BIOS setup page.
> > diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> > index 002078645969..6e1c1b0ce015 100644
> > --- a/arch/x86/platform/efi/efi.c
> > +++ b/arch/x86/platform/efi/efi.c
> > @@ -80,6 +80,7 @@ static const unsigned long * const efi_tables[] =3D {
> >         &efi.esrt,
> >         &efi.properties_table,
> >         &efi.mem_attr_table,
> > +       &rci2_table_phys,
>=20
> Put #ifdef CONFIG_EFI_RCI2 around this line ^^^
>=20
> >  };
> >
> >  u64 efi_setup;         /* efi setup_data physical address */
> > diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makef=
ile
> > index d2d0d2030620..db07828ca1ed 100644
> > --- a/drivers/firmware/efi/Makefile
> > +++ b/drivers/firmware/efi/Makefile
> > @@ -11,7 +11,7 @@
> >  KASAN_SANITIZE_runtime-wrappers.o      :=3D n
> >
> >  obj-$(CONFIG_ACPI_BGRT)                +=3D efi-bgrt.o
> > -obj-$(CONFIG_EFI)                      +=3D efi.o vars.o reboot.o mema=
ttr.o tpm.o
> > +obj-$(CONFIG_EFI)                      +=3D efi.o vars.o reboot.o mema=
ttr.o tpm.o rci2_table.o
>=20
> Please introduce a kconfig symbol CONFIG_EFI_RCI2 for this, and only
> include this file when the symbol is set. You can make it default to y
> on X86, but for other architectures, it does not make a lot of sense
> to include this by default.

Apologies for the delay in responding. I will add the kconfig option and
related changes in the next version of the patch. I think the config
option could be N by default with a note added in the help section to
set it to Y for Dell EMC PowerEdge systems. Please share your thoughts
on setting it to N by default.

[...]

--=20
With regards,
Narendra K=

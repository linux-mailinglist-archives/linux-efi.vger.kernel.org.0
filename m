Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9728954E6D
	for <lists+linux-efi@lfdr.de>; Tue, 25 Jun 2019 14:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfFYMKT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Jun 2019 08:10:19 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:7286 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726659AbfFYMKT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Jun 2019 08:10:19 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PC5CVC028543
        for <linux-efi@vger.kernel.org>; Tue, 25 Jun 2019 08:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=smtpout1;
 bh=RK49Tnad4yuToc/ogT1N5rurND55izahbAIzT0x4szA=;
 b=Ew4YXw/GzUFauahLe9YfuYITm87yG9O8BpiboVndyYZebO70VspLI4MNXiPMszIywvO1
 2o9uZdP9JvfItDvkIu3pKJLs+v2X5szPJY0O+ovpl8IaPYxkJkUDm6vFIY7eJDJTzMjT
 0yJssEhAjx0FgNAWJQ5HzGArlWqkOpuCVnHOcqBLZa/nx0gIauul4V2zmyPqkf9AzkTh
 aOYYT7xDs5NfHPBgwMxWy9vK21sK3vzb2QdyUKlvL9FSblB+x15fRrvxKLMYAybUUSDA
 npQl937/LLlXqYsyjatEHIgiVBXG9q+Ei7GqIfgJ/SDBFHiInuXs1lfsA6WVxlXuslgx 7g== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2tbjnu057q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Tue, 25 Jun 2019 08:10:17 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PC4kib026689
        for <linux-efi@vger.kernel.org>; Tue, 25 Jun 2019 08:10:17 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0a-00154901.pphosted.com with ESMTP id 2tbj14hh74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-efi@vger.kernel.org>; Tue, 25 Jun 2019 08:10:16 -0400
X-LoopCount0: from 10.166.132.71
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="382277269"
From:   <Narendra.K@dell.com>
To:     <ard.biesheuvel@linaro.org>
CC:     <pjones@redhat.com>, <linux-efi@vger.kernel.org>
Subject: Re: [RFC PATCH] Export Runtime Configuration Interface table to sysfs
Thread-Topic: [RFC PATCH] Export Runtime Configuration Interface table to
 sysfs
Thread-Index: AQHVJPURJUa43Zv1v02xbnzCeW3iXaal+J4AgAX/BAA=
Date:   Tue, 25 Jun 2019 12:10:11 +0000
Message-ID: <20190625120944.GA4465@localhost.localdomain>
References: <20190617101134.GA2242@localhost.localdomain>
 <CAKv+Gu_MYJ=EWOphS=dBG8PJqPjG21J9SGrynD2r60SOemttUA@mail.gmail.com>
In-Reply-To: <CAKv+Gu_MYJ=EWOphS=dBG8PJqPjG21J9SGrynD2r60SOemttUA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6C1FB8E4751898429D156D16899D0249@dell.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250098
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906250098
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 21, 2019 at 06:35:42PM +0200, Ard Biesheuvel wrote:
> (+ Peter)
>=20
> On Mon, 17 Jun 2019 at 12:11, <Narendra.K@dell.com> wrote:
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
[...]
> > ---
> > Hi, the patch is created on kernel version 5.2-rc4. It applies to
> > 5.2-rc5 also. If the approach looks correct, I will resubmit with RFC
> > tag removed.
> >

Hi Ard,

Thank you for the review comments.=20

> Unfortunately, we cannot implement a  generic interface for dumping
> config tables, since there is no generic method to record the length.
> So I don't have any problems with doing it this way.
>=20
> I do have some comments, though.
>=20
> First of all, do you know which memory type is used for this table? (more=
 below)

The memory type used for the table is EfiReservedMemoryType.

[...]
> > +obj-$(CONFIG_EFI)                      +=3D efi.o vars.o reboot.o mema=
ttr.o tpm.o rci2_table.o
> >  obj-$(CONFIG_EFI)                      +=3D capsule.o memmap.o
> >  obj-$(CONFIG_EFI_VARS)                 +=3D efivars.o
> >  obj-$(CONFIG_EFI_ESRT)                 +=3D esrt.o
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 16b2137d117c..2fe114ff8149 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -53,6 +53,7 @@ struct efi __read_mostly efi =3D {
> >         .rng_seed               =3D EFI_INVALID_TABLE_ADDR,
> >         .tpm_log                =3D EFI_INVALID_TABLE_ADDR,
> >         .mem_reserve            =3D EFI_INVALID_TABLE_ADDR,
> > +       .rci2                   =3D EFI_INVALID_TABLE_ADDR,
>=20
> Does this really need to live in the efi struct?

It probably need not be part of struct efi. We could define a struct of
type 'efi_config_table_type_t' in the rci2_table.c. Did you have a
similar idea in mind ? If yes, I will modify and test this idea.

>=20
> >  };
> >  EXPORT_SYMBOL(efi);
> >
> > @@ -73,6 +74,7 @@ static unsigned long *efi_tables[] =3D {
> >         &efi.esrt,
> >         &efi.properties_table,
> >         &efi.mem_attr_table,
> > +       &efi.rci2,
> >  };
> >
>=20
> AFAICT, this table is only used by memremap_is_efi_data() to decide
> whether a page should be map as unencrypted, and if the address is in
> boot services data or runtime services data, the test will already
> success, regardless of whether it appears in this enumeration.

Yes. Before 'memremap_is_efi_data()' checks if the memory type is boot
services data for runtime services data, it checks if the address is a
'table' address in 'efi_is_table_address'. I added it because of this
check. Since the memory type used for the table is efi reserved type, we
need to add the table address to 'efi_tables' array so that it could be
checked in 'efi_is_table_address'. Please share your thought on this.

>=20
> >  struct mm_struct efi_mm =3D {
> > @@ -384,6 +386,9 @@ static int __init efisubsys_init(void)
> >                 goto err_remove_group;
> >         }
> >
> > +       if (efi_rci2_sysfs_init() !=3D 0)
> > +               pr_debug("efi rci2: sysfs attribute creation under /sys=
/firmware/efi/ failed");
> > +
> >         return 0;
> >
> >  err_remove_group:
> > @@ -488,6 +493,12 @@ static __initdata efi_config_table_type_t common_t=
ables[] =3D {
> >         {NULL_GUID, NULL, NULL},
> >  };
> >
> > +/* OEM Tables */
> > +static __initdata efi_config_table_type_t oem_tables[] =3D {
> > +       {DELLEMC_EFI_RCI2_TABLE_GUID, "RCI2", &efi.rci2},
>=20
> Please drop the string. We don't have to print the presence of this
> table in the bootlog since it has no significance to the OS itself.

Okay. I will drop this in the next version of the patch.

>=20
> > +       {NULL_GUID, NULL, NULL},
> > +};
> > +
>=20
> Do we really need a separate oem_tables[] array?

The RCI2 table did not seem to be part of the group of common tables=20
such as SMBIOS and ACPI. To indicate this, I created a separate array.=20
It seems like it is not required. Having the array allows to leverage=20
the table matching code in 'match_config_table' function. Would you prefer=
=20
to have this entry added to the 'common_tables' array ? =20

[...]
> > +
> > +int __init efi_rci2_table_init(void)
> > +{
> > +       rci2_base =3D early_memremap(efi.rci2,
> > +                                  sizeof(struct rci2_table_global_hdr)=
);
> > +       if (!rci2_base) {
> > +               pr_debug("RCI2 table init failed - could not map RCI2 t=
able\n");
> > +               return -ENOMEM;
> > +       }
> > +
>=20
> Do we really need to do this early? And is it guaranteed that the
> memory will not be given to the OS for general allocation?

As the memory type is efi reserved type, it is guaranteed that the
memory will not be give to OS for general allocation. It is mapped here
to determine the size of the table and unmapped in the same function.

Would you prefer to merge this function into 'efi_rci2_sysfs_init' function=
 ?

>=20
>=20
> > +       if (strncmp(rci2_base +
> > +                   offsetof(struct rci2_table_global_hdr, rci2_sig),
> > +                   RCI_SIGNATURE, 4)) {
> > +               memunmap(rci2_base);
> > +               pr_debug("RCI2 table init failed - incorrect signature\=
n");
> > +               return -ENODEV;
> > +       }
> > +
> > +       rci2_table_len =3D *(u32 *)(rci2_base +
> > +                                 offsetof(struct rci2_table_global_hdr=
,
> > +                                 rci2_len));
> > +
> > +       early_memunmap(rci2_base, sizeof(struct rci2_table_global_hdr))=
;
> > +
> > +       return 0;
> > +}

[...]

> > +
> > +static u16 checksum(void)
> > +{
> > +       u8 len_is_odd =3D rci2_table_len % 2;
> > +       u32 chksum_len =3D rci2_table_len;
> > +       u16 *base =3D (u16 *)rci2_base;
> > +       u8 buf[2] =3D {0};
> > +       u32 offset =3D 0;
> > +       u16 chksum =3D 0;
> > +
> > +       if (len_is_odd)
> > +               chksum_len -=3D 1;
> > +
> > +       while (offset < chksum_len) {
> > +               chksum +=3D *base;
> > +               offset +=3D 2;
> > +               base++;
> > +       }
> > +
> > +       if (len_is_odd) {
> > +               buf[0] =3D *(u8 *)base;
> > +               chksum +=3D *(u16 *)(buf);
> > +       }
> > +
> > +       return chksum;
> > +}
> > +
>=20
> What is this random checksum function? Which algorithm does it
> implement, and did you check whether we already have a library
> function for it?

It does not implement any algorithm. The 16 bit sum of rci2_chksum field in=
 the=20
struct rci2_table_global_hdr and rest of bytes of the table needs to be zer=
o.=20
If length of the table is odd, a single byte  with value zero needs to be a=
dded=20
at the end for the purpose of checksum calculation.

I checked in the library and did not find a function implementing
similar functionality. Please let me know if I missed any detail here.=20

>=20
>=20
> > +int __init efi_rci2_sysfs_init(void)
> > +{
> > +
> > +       struct kobject *tables_kobj;
> > +       int ret =3D -ENOMEM;
> > +
> > +       if (!rci2_table_len)
> > +               goto err;
> > +
> > +       rci2_base =3D memremap(efi.rci2, rci2_table_len, MEMREMAP_WB);
> > +       if (!rci2_base) {
> > +               pr_debug("RCI2 table - could not map RCI2 table\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       if (checksum() !=3D 0) {
> > +               pr_debug("RCI2 table - incorrect checksum\n");
> > +               ret =3D -ENODEV;
> > +               goto err_unmap;
> > +       }
> > +
> > +       tables_kobj =3D kobject_create_and_add("tables", efi_kobj);
> > +       if (!tables_kobj) {
> > +               pr_debug("RCI2 table - tables_kobj creation failed\n");
> > +               goto err_unmap;
> > +       }
> > +
> > +       bin_attr_rci2.size =3D rci2_table_len;
> > +       bin_attr_rci2.private =3D rci2_base;
> > +       ret =3D sysfs_create_bin_file(tables_kobj, &bin_attr_rci2);
> > +       if (ret !=3D 0) {
> > +               pr_debug("RCI2 table - rci2 sysfs bin file creation fai=
led\n");
> > +               kobject_del(tables_kobj);
> > +               kobject_put(tables_kobj);
> > +               goto err_unmap;
> > +       }
> > +
> > +       return 0;
> > +
> > + err_unmap:
> > +       memunmap(rci2_base);
> > + err:
> > +       pr_debug("RCI2 table - sysfs initialization failed\n");
> > +       return ret;
> > +}
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index 6ebc2098cfe1..3a3f37ee5c48 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -691,6 +691,9 @@ void efi_native_runtime_setup(void);
> >  #define LINUX_EFI_TPM_EVENT_LOG_GUID           EFI_GUID(0xb7799cb0, 0x=
eca2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
> >  #define LINUX_EFI_MEMRESERVE_TABLE_GUID                EFI_GUID(0x888e=
b0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
> >
> > +/* OEM GUIDs */
> > +#define DELLEMC_EFI_RCI2_TABLE_GUID            EFI_GUID(0x2d9f28a2, 0x=
a886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
> > +
> >  typedef struct {
> >         efi_guid_t guid;
> >         u64 table;
> > @@ -997,6 +1000,7 @@ extern struct efi {
> >         unsigned long rng_seed;         /* UEFI firmware random seed */
> >         unsigned long tpm_log;          /* TPM2 Event Log table */
> >         unsigned long mem_reserve;      /* Linux EFI memreserve table *=
/
> > +       unsigned long rci2;             /* Dell EMC EFI RCI2 Table */
> >         efi_get_time_t *get_time;
> >         efi_set_time_t *set_time;
> >         efi_get_wakeup_time_t *get_wakeup_time;
> > @@ -1712,6 +1716,9 @@ struct linux_efi_tpm_eventlog {
> >
> >  extern int efi_tpm_eventlog_init(void);
> >
> > +extern int efi_rci2_table_init(void);
> > +extern int efi_rci2_sysfs_init(void);
> > +
> >  /*
> >   * efi_runtime_service() function identifiers.
> >   * "NONE" is used by efi_recover_from_page_fault() to check if the pag=
e
> > --
> > 2.18.1
> >
> > With regards,
> > Narendra K
--=20
With regards,
Narendra K=

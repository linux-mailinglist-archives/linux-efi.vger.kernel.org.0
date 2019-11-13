Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37CCFFABC3
	for <lists+linux-efi@lfdr.de>; Wed, 13 Nov 2019 09:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKMIGW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Nov 2019 03:06:22 -0500
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212]:11078 "EHLO
        esa3.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726120AbfKMIGW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Nov 2019 03:06:22 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Nov 2019 03:06:20 EST
IronPort-SDR: Z4E2GuT5R7DOkREu5TNXGE0CEejSWa4Xmh/VcGw/DWRIOYlrNVA8rugqFfhxfDsGG1Z5s8SjZK
 0uAtFbN7OjqpHa1dUPwpIaRFeigEsGSi0bR4SzGEFBLJApjeOJCpRxMSoQOwXAZ4C2VRSS1KFB
 97xfY4K1XQBukiua8jJ+pBv1LY58w60oIKm6Gg2CQ3j6oD2YE1OwcrtTIoyAzzEwaaA6sU0PRz
 fCDiXqGRQpPlrXM2CtSJ5rjalgy/fsEKJB3VXfKsLZW89wIxw86BkwbV+M+cNjQVjQ9MkIDKdd
 2GI=
X-IronPort-AV: E=McAfee;i="6000,8403,9439"; a="15738084"
X-IronPort-AV: E=Sophos;i="5.68,299,1569250800"; 
   d="scan'208";a="15738084"
Received: from mail-os2jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 16:59:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPeUg4aX1jBfv+XEcLNgw7FVS9WkFQW7FqzarPkp8whsoU/69mvJVxL+epVdotMhwm/rQ1wJDwqF5Ue83iXqjsI6t/GldlRAv2iB4QRJIjdQNbN0pWUvCYZtVY/pUZrqWlIvPmzihfpybUsV7oayR4kB+k4S28oRZuCe9qfv1EEYh8/pYvkXrt6tvnnR5wPJAYzQRIKO0BxmnFzV5gMrb7tHdS9FE7DT/G069fGkBF9V6ojGU71sC4Pqi4/aOcQvPgy9g/1xySe4/Jgsrh9/u72NzZN1e27BmG1XOGLnxWnvFHm4rrRt6FENct3G4ZoTraqD3/u+ywkx6zIeait7Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2d/8YDW++kfz9Fiy68ZWmrgkz8/Y0W3Dr0oleyvLuAA=;
 b=kx0PVufBO8qqkpx4dZq5V/MOKpHqfvgdnlPzm3KiN7J1hCFX3LxKALd8B2UXqPB4iBhvu+6yaKIzlptcnfuy280fS3YCiwnsj+ka7T7zL9m83mbISKp79MdZlDmgK8o2kp1TmoZ4+4f7nhFLkA4qBkbQOyq4cM9JiXkJzGuG0Mog3meTPXhK4Sd1RrBd9S4g/DAhdPcrOW6eM4v+bKxC0S5AWPE6Avlj8YfEfBvGQNlnyT1Bpwa+fkAJkgMrU0dsOfSqwgJcR8UtubyYNdhDkhkdfOYAKWoQShgLoU80qczAmgMIB3MQWu7I29uTT+C58R7024QGjZmY6YqeDJx4GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2d/8YDW++kfz9Fiy68ZWmrgkz8/Y0W3Dr0oleyvLuAA=;
 b=DfTtgx520yFFaZBJ/LgcivKvISpjKybJV9DkWdi78+6V34I7O5KgJnY78viQ2I39E9fVDFh+8jXt+7SGncNGYstyUDP7+SrkWWhMmzfknMX3YvOqkd2DHYYjDLHF3hdXuTOtgBAnh5LARDQnaCURYtS8C4xVn2BG4TWMddBEpC4=
Received: from OSBPR01MB4006.jpnprd01.prod.outlook.com (20.178.98.151) by
 OSBPR01MB2135.jpnprd01.prod.outlook.com (52.134.241.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Wed, 13 Nov 2019 07:59:05 +0000
Received: from OSBPR01MB4006.jpnprd01.prod.outlook.com
 ([fe80::5849:132c:5ff5:db9b]) by OSBPR01MB4006.jpnprd01.prod.outlook.com
 ([fe80::5849:132c:5ff5:db9b%6]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 07:59:05 +0000
From:   "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
To:     'Masayoshi Mizuma' <msys.mizuma@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
CC:     "m.mizuma@jp.fujitsu.com" <m.mizuma@jp.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: RE: [RFC PATCH] efi: arm64: Introduce /sys/firmware/efi/memreserve to
 tell the persistent pages
Thread-Topic: [RFC PATCH] efi: arm64: Introduce /sys/firmware/efi/memreserve
 to tell the persistent pages
Thread-Index: AQHVmXnc+H1L3uC5sEGo7W/YjoCzWqeIuDNQ
Date:   Wed, 13 Nov 2019 07:59:04 +0000
Message-ID: <OSBPR01MB4006D6F586695E2B867C95F095760@OSBPR01MB4006.jpnprd01.prod.outlook.com>
References: <20191112165303.24270-1-msys.mizuma@gmail.com>
In-Reply-To: <20191112165303.24270-1-msys.mizuma@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=d.hatayama@fujitsu.com; 
x-originating-ip: [210.162.184.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec8e323a-36f0-459c-d136-08d7680f5a9f
x-ms-traffictypediagnostic: OSBPR01MB2135:|OSBPR01MB2135:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB2135E64A4AD5244FD6AF9C8F95760@OSBPR01MB2135.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(189003)(199004)(13464003)(110136005)(316002)(2201001)(25786009)(2501003)(86362001)(102836004)(486006)(229853002)(54906003)(6506007)(53546011)(71200400001)(71190400001)(2906002)(476003)(76176011)(9686003)(14444005)(256004)(6116002)(3846002)(26005)(66066001)(4326008)(478600001)(8676002)(81156014)(14454004)(76116006)(11346002)(6436002)(33656002)(85182001)(5660300002)(8936002)(7736002)(64756008)(305945005)(81166006)(186003)(55016002)(66556008)(446003)(66946007)(6246003)(99286004)(66446008)(7696005)(74316002)(66476007)(52536014)(777600001);DIR:OUT;SFP:1101;SCL:1;SRVR:OSBPR01MB2135;H:OSBPR01MB4006.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IgFn6Is7+tNxFMmodGIlbMQzB4DQ/DjYw3TVsXFhul2idbwwmrDH6YIuFOf5qrvwdKuQqRGWz7UmrnUtL4pIjiGc/nTxfSnKJAjrycI7D7+tjoietrcb8Ia3fQtmFBZbUZyIKMDWQSqlo3YMAthZg+QXhi+T+MQXVjoTSN1mq+Grd26O8+4tr2RTzNgDgWJCRfPKDiLsCwWYDLZ56A+0yPMQYBmAR0nqmUnkaAmNbqac2O6YBv7yyhw/j/sSfK/r+0aKn/jtdUb4/scO8QYSejOqMM95sVa71EUBY4zstAeMecWIDEWsZJ0YxGTk3BFo1MBF+WtsZrkO89jzAARqBthhyAwFwgD8UhMAgbTTLFNZsghrpcU6VepHhgmwfKBXWcaF9dfmrCWMGB6qhioB9odsVjcyt3urQx85gs+rL6Hq8phUm1RkFEf1Hqn2MP6W
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8e323a-36f0-459c-d136-08d7680f5a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 07:59:04.8916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sU2NlG6rU4qzWbbzUyEoQCquxDzaTcpGR8o2bsArBaMzEHk/I9CgOZnbt3HCQPKXvgC1w7LWGSCUoNwIxqcEjrD87XjD/e/hc0nX6LHi3Wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2135
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Masayoshi Mizuma
> Sent: Wednesday, November 13, 2019 1:53 AM
> To: Ard Biesheuvel <ard.biesheuvel@linaro.org>;
> linux-arm-kernel@lists.infradead.org; linux-efi@vger.kernel.org
> Cc: Masayoshi Mizuma <msys.mizuma@gmail.com>; Mizuma, Masayoshi/=1B$B?e4V=
=1B(B =1B$BM}?N=1B(B
> <m.mizuma@jp.fujitsu.com>; linux-kernel@vger.kernel.org;
> kexec@lists.infradead.org
> Subject: [RFC PATCH] efi: arm64: Introduce /sys/firmware/efi/memreserve t=
o
> tell the persistent pages
>=20
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>=20
> kexec reboot stucks because efi_config_parse_tables() refers garbage
>  (with memblock=3Ddebug):
>=20
>   efi:  ACPI 2.0=3D0x9821790014  PROP=3D0x8757f5c0  SMBIOS 3.0=3D0x982074=
0000
> MEMRESERVE=3D0x9820bfdc58
>   memblock_reserve: [0x0000009820bfdc58-0x0000009820bfdc67]
> efi_config_parse_tables+0x228/0x278
>   memblock_reserve: [0x0000000082760000-0x00000000324d07ff]
> efi_config_parse_tables+0x228/0x278
>   memblock_reserve: [0xcc4f84ecc0511670-0x5f6e5214a7fd91f9]
> efi_config_parse_tables+0x244/0x278
>   memblock_reserve: [0xd2fd4144b9af693d-0xad0c1db1086f40a2]
> efi_config_parse_tables+0x244/0x278
>   memblock_reserve: [0x0c719bb159b1fadc-0x5aa6e62a1417ce12]
> efi_config_parse_tables+0x244/0x278
>   ...
>=20
> That happens because 0x82760000, struct linux_efi_memreserve, is destroye=
d.
> 0x82760000 is pointed from efi.mem_reseve, and efi.mem_reserve points the
> head page of pending table and prop table which are allocated by
> gic_reserve_range().
>=20
> The destroyer is kexec. kexec locates the inird to the area:
>=20
> # kexec -d -l /boot/vmlinuz-5.4.0-rc7 /boot/initramfs-5.4.0-rc7.img
> --reuse-cmdline
> ...
> initrd: base 82290000, size 388dd8ah (59301258)
> ...
>=20
> From dynamic debug log:
>   machine_kexec_prepare:70:
>     kexec kimage info:
>       type:        0
>       start:       85b30680
>       head:        0
>       nr_segments: 4
>         segment[0]: 0000000080480000 - 0000000082290000, 0x1e10000 bytes,=
 481
> pages
>         segment[1]: 0000000082290000 - 0000000085b20000, 0x3890000 bytes,=
 905
> pages
>         segment[2]: 0000000085b20000 - 0000000085b30000, 0x10000 bytes, 1
> pages
>         segment[3]: 0000000085b30000 - 0000000085b40000, 0x10000 bytes, 1
> pages
>=20
> kexec searches the appropriate memory region to locate initrd through "Sy=
stem
> RAM"
> in /proc/iomem. The pending tables are included in "System RAM" because t=
hey
> are
> allocated by alloc_pages(), so kexec destroys the pending tables.
>=20
> Introduce /sys/firmware/efi/memreserve to tell the pages pointed by
> efi.mem_reserve
> so that kexec can avoid the area to locate initrd.
>=20
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  drivers/firmware/efi/efi.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index e98bbf8e5..67b21ae7a 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -141,6 +141,36 @@ static ssize_t systab_show(struct kobject *kobj,
>=20
>  static struct kobj_attribute efi_attr_systab =3D __ATTR_RO_MODE(systab, =
0400);
>=20
> +static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
> +static ssize_t memreserve_show(struct kobject *kobj,
> +			   struct kobj_attribute *attr, char *buf)
> +{
> +	struct linux_efi_memreserve *rsv;
> +	unsigned long prsv;
> +	char *str =3D buf;
> +	int index, i;
> +
> +	if (!kobj || !buf)
> +		return -EINVAL;
> +
> +	if (!efi_memreserve_root)
> +		return -ENODEV;

Other functions use different conditions.
The latter efi_memreserve_root =3D=3D (void *)ULONG_MAX is correct?

static int __init efi_memreserve_map_root(void)
{
        if (efi.mem_reserve =3D=3D EFI_INVALID_TABLE_ADDR)
                return -ENODEV;

int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
{
        struct linux_efi_memreserve *rsv;
        unsigned long prsv;
        int rc, index;

        if (efi_memreserve_root =3D=3D (void *)ULONG_MAX)
                return -ENODEV;

> +
> +	for (prsv =3D efi_memreserve_root->next; prsv; prsv =3D rsv->next) {
> +		rsv =3D memremap(prsv, sizeof(*rsv), MEMREMAP_WB);

memremap() could fail with NULL as a return value.
You need to deal with such case.

It looks to me efi_mem_reserve_persistent() also doesn't deal with this.
Maybe you should fix this, too.

> +		index =3D atomic_read(&rsv->count);
> +		for (i =3D 0; i < index; i++)
> +			str +=3D sprintf(str, "%llx-%llx\n",
> +				rsv->entry[i].base,
> +				rsv->entry[i].base + rsv->entry[i].size -
> 1);

Is memreserve supported on 32-bit system?
If so, phy_addr_t could have a type of 4-byte length in such system
(not so if with PAE) and then %llx could lead to inconsistent type error.
It's enough to add a cast to unsigned long long.

> +		memunmap(rsv);
> +	}
> +
> +	return str - buf;
> +}
> +
> +static struct kobj_attribute efi_attr_memreserve =3D
> __ATTR_RO_MODE(memreserve, 0444);
> +
>  #define EFI_FIELD(var) efi.var
>=20
>  #define EFI_ATTR_SHOW(name) \
> @@ -172,6 +202,7 @@ static struct attribute *efi_subsys_attrs[] =3D {
>  	&efi_attr_runtime.attr,
>  	&efi_attr_config_table.attr,
>  	&efi_attr_fw_platform_size.attr,
> +	&efi_attr_memreserve.attr,
>  	NULL,
>  };
>=20
> @@ -955,7 +986,6 @@ int efi_status_to_err(efi_status_t status)
>  }
>=20
>  static DEFINE_SPINLOCK(efi_mem_reserve_persistent_lock);
> -static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
>=20
>  static int __init efi_memreserve_map_root(void)
>  {
> --
> 2.18.1


Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAD5269244
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 18:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgINQ5j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 12:57:39 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:45378 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725976AbgINQ5E (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Sep 2020 12:57:04 -0400
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08EGocsu002055;
        Mon, 14 Sep 2020 12:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=1FqYqIa8MlTZrjnSSKkbFf+EehSwouFL4c45obeHkoY=;
 b=hZRhvSZ08ygf8Zdmjt5MMGxCkFctgeQmzRrZ6gcJrJ71o0kOpADYeezm3cQqn2KfpdMq
 a4oaKZMXlXQpK+r9nByeV4HBoKoydxjfWA7kgHdGdaL5T78gwxaNbuY+YP/pOWTeDzhg
 CTs6ZyL16cRU9S6FfQiDmEmfZCKLkeeg2Y5KWIcbzBp8QxdaWJwpZzFHzITz2fL2D8ar
 wuH+z0lZDUTC4sf9BER8j1lF3YrED6JYVktXVrX/qHaLqWAxxv9l80FSGCm1bOqo1WlO
 1N/Tzc9QiKm+lwKOxmqEC9SBUquPkEdBBeMWRwWrN1oalV1t4gbHxYgP5aRA19bNuz02 KA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 33grw6drc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 12:56:55 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08EGsT7l087193;
        Mon, 14 Sep 2020 12:56:55 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-00154901.pphosted.com with ESMTP id 33jceqr143-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Sep 2020 12:56:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJdBPb2ONsT0XfcigwrdBDy3Yst03QjwCy25vT7PDj3QUNurN6Nz3BXsVgk2+pofk1vDnULjty5tTYnjago10iox/WQOZE+iffn+CqTDaK2bwQMRDgl2NJFmtQlve4lL9g+m5xo86p8M/YDnSvYTrDTsPFGs22OWGIiMg/PqyvYzDYV6ROQ+p0gEQhRvPjpR5SPGp9AX+vwrBwn1ItMihLvfzT9lcga7AYIvbD2LVDNsnD6CqZSlKkbpUzjHNH/FQdAjlu92YdYStfmuubeub0SHTsyTGZ6DHBWSmSdFhkMgeRPEl36DlgZJcfp/iw2zFsJOOq100I8xnROt64hb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FqYqIa8MlTZrjnSSKkbFf+EehSwouFL4c45obeHkoY=;
 b=hytN3A31gjbjAYzO/zQqaHJXqUO+wdG4Oi4gmZzBXx15nFOWzEmyKmWJGa/L2US37yeRr7hAwld2hGi1CunVlBfxUGQ4lpKT/4PrxXMARkCXeHuFkXvhDRfPrcbQHEe+fE++IvUAPPj5rNyf6GixXU+ed0MFt46kTW2mIz9Yk4QnxRWn5xpzW3GVD5Emrt0ic1jXsw23sERUUH21M77TIp/KacuYowY8lvQXFlUJR7SKjjCXf02RqqlQs3yInEtFqWznqFlPh48wIwUMMy37ORMtmx4kea1CJsJDbq4qO36F4V16TbDb5SfW3hoK0/D8hiJakv9UHGoj6ZKY9i9tFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FqYqIa8MlTZrjnSSKkbFf+EehSwouFL4c45obeHkoY=;
 b=Mznn5/Z5CYoy3hYM6fYX70IDKrZx+hZGiFIQitqhHwOYAwTkU9y6cdjrTGQXcmN+xcJTxh2W4SlY36AN+T1AuJkoEUOaRRTZZEycvPFTWTi6v7VJn+f4Dv1CO9NVmzVexAcGeoBQbBYHnnElsuh6X9YZy1W6piAxqkiCa9HxtXk=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM6PR19MB3066.namprd19.prod.outlook.com (2603:10b6:5:187::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 16:56:52 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 16:56:52 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Jacobo Pantoja <jacobopantoja@gmail.com>
CC:     Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: RE: [RFC PATCH 1/2] efi/x86: Add a quirk to support command line
 arguments on Dell EFI firmware
Thread-Topic: [RFC PATCH 1/2] efi/x86: Add a quirk to support command line
 arguments on Dell EFI firmware
Thread-Index: AQHWiS1NRxKz7Ka8wkKNd8qkUMWbaqloW/rw
Date:   Mon, 14 Sep 2020 16:56:52 +0000
Message-ID: <DM6PR19MB26366FAF28A730412DC505EDFA230@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <DM6PR19MB2636D9FB53FD32BC8F3FFFE4FA240@DM6PR19MB2636.namprd19.prod.outlook.com>
 <20200912175105.2085299-1-nivedita@alum.mit.edu>
 <20200912175105.2085299-2-nivedita@alum.mit.edu>
In-Reply-To: <20200912175105.2085299-2-nivedita@alum.mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-14T16:56:50.6041932Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=de525b41-cbc6-4ba5-8ab4-4aaed0929b57;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: alum.mit.edu; dkim=none (message not signed)
 header.d=none;alum.mit.edu; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2fc5f64-4628-47d4-aa50-08d858cf2dc8
x-ms-traffictypediagnostic: DM6PR19MB3066:
x-microsoft-antispam-prvs: <DM6PR19MB306651E4CE6C8B0D22BF1C9BFA230@DM6PR19MB3066.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KajRmEGiSa2DU9Z0xmj7OdhFCepIwmKNnJ76HhlCMYFLWAkr8iQ36eA5uMu0N4dRUcTyj0koFIsllKcn6VeoItSN7uwgPgu2yCZKHFqI0II8bZc+RteLC4G1bu1snZKG75apLRIwmFH5mX0PFR1nHcdQTgqCqF3BcH0HzXbE0Tk85M/pkULUD5v+rsAzK+zJ5pfA4zc9R5hZOlDS7r0Kp50zjyJhG+ufz9jeN3gqTeqkxygWjgFlGc8nHGYROJ3eWD1Z9+g3CKiMQEYPrALE5q9E9qkLLtkLwBSVOaXDRywUxHwYcQmTpVx/ftLIeQN8uMQsyLTCTIEZTbiFxuOXNIOnFoGO4aPsC7WiGfQBlL+TcM2kxjJLHGAiXAkn892R7GpmJP8Ct9T/F3VDpfe/LA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(39860400002)(396003)(71200400001)(786003)(316002)(52536014)(66446008)(64756008)(66556008)(66476007)(7696005)(53546011)(6506007)(66946007)(76116006)(9686003)(26005)(2906002)(478600001)(186003)(5660300002)(33656002)(55016002)(54906003)(8936002)(4326008)(86362001)(110136005)(966005)(8676002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 9m9sun1A1WD7Iy9efGNRVwRY6dNyS9D+vHBQlF4IN+cyu3RC88pqTYHQPNoA8qJbLoS3ZG2hHKLujuoVzjy9MNeWDyRO661X8UBeo/VHVZQoZ23FaZ3NHEYqKGoY1jDWIt7DL1PtG0wDmEiy72y+D7unZ0uGQAhkw0I8H0lUablZyAH0Jyx92pyCC+aQGlagTbZgvF8PRCKnxs55+l4Q3pfbrlzADiRW7xe/8NMNfeTjzJrIe6h1GaWIrfxvg4Bo6iYewd90U5mQEfDRKUw9oAEhY7uZTyL4jUbgni1bHGNWU8glrfZp/IGteg4xcznmqmZwIwG/zvkhyLWK7GcFKx11BqSZlXZAUPhy5p+i3i6YuZWjk6/GEcvweDWpMoETA9LY678iW4EUwPLJsNJRH8XNki968qdLcXvOxn/HHlLpRu2juxfUIoQEecjYULHYAg3n8Oq2db7W4huTuYD1qgEhDCYEZUEHG+SlwPao5fNyl1tmptjt4jiU7Qm/H/6aiD2z3Ugd1VRVvFda32GDrYE6z+9swwdlhjTcGmrQQuVerUQDqKk0tXChwjvSiavJdv82KDNpRgdbpsIMy3iMXyBfuPm1voVzovHBUNqmuXKAcTQ0v0MMsfk1DdUTBXPvh1Hy9o5unwPTP1MefqONQg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fc5f64-4628-47d4-aa50-08d858cf2dc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 16:56:52.1285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L54813wd0GjBjSW/JN+OZftlGPjH6WLrDcm8c0+JUM3GiKui7+PiGdcINZPtTwit28OVdu50Q0/+aJlOoXkP/5UsARip1R0ta5k14f5e2Kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3066
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-14_06:2020-09-14,2020-09-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140136
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140136
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> -----Original Message-----
> From: Arvind Sankar <nivedita@alum.mit.edu>
> Sent: Saturday, September 12, 2020 12:51
> To: Jacobo Pantoja
> Cc: Limonciello, Mario; Ard Biesheuvel; Peter Jones; linux-efi
> Subject: [RFC PATCH 1/2] efi/x86: Add a quirk to support command line
> arguments on Dell EFI firmware
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> At least some versions of Dell EFI firmware pass the entire
> EFI_LOAD_OPTION descriptor, rather than just the OptionalData part, to
> the loaded image.
>=20
> To handle this, add a quirk to check if the options look like a valid
> EFI_LOAD_OPTION descriptor, and if so, use the OptionalData part as the
> command line.

I think it would be useful to document in the commit message the specifics
of at least the failure reported by Jacobo (Precision T3620 FW 2.15.0).

>=20
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Reported-by: Jacobo Pantoja <jacobopantoja@gmail.com>
> Link: https://lore.kernel.org/linux-
> efi/20200907170021.GA2284449@rani.riverdale.lan/
> ---
>  .../firmware/efi/libstub/efi-stub-helper.c    | 99 ++++++++++++++++++-
>  drivers/firmware/efi/libstub/efistub.h        | 31 ++++++
>  drivers/firmware/efi/libstub/file.c           |  5 +-
>  3 files changed, 133 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c
> b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index f735db55adc0..294958ff1ee6 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -238,6 +238,100 @@ efi_status_t efi_parse_options(char const *cmdline)
>  	return EFI_SUCCESS;
>  }
>=20
> +/*
> + * The EFI_LOAD_OPTION descriptor has the following layout:
> + *	u32 Attributes;
> + *	u16 FilePathListLength;
> + *	u16 Description[];
> + *	efi_device_path_protocol_t FilePathList[];
> + *	u8 OptionalData[];
> + *
> + * This function validates and unpacks the variable-size data fields.
> + */
> +static
> +bool efi_load_option_unpack(efi_load_option_unpacked_t *dest,
> +			    const efi_load_option_t *src, size_t size)
> +{
> +
> +	const void *pos;
> +	u16 c;
> +	efi_device_path_protocol_t header;
> +	const efi_char16_t *description;
> +	const efi_device_path_protocol_t *file_path_list;

Should re-order to reverse xmas tree order.

> +
> +	if (size < offsetof(efi_load_option_t, variable_data))
> +		return false;
> +	pos =3D src->variable_data;
> +	size -=3D offsetof(efi_load_option_t, variable_data);
> +
> +	if ((src->attributes & ~EFI_LOAD_OPTION_MASK) !=3D 0)
> +		return false;
> +
> +	/* Scan description. */
> +	description =3D pos;
> +	do {
> +		if (size < sizeof(c))
> +			return false;
> +		c =3D *(const u16 *)pos;
> +		pos +=3D sizeof(c);
> +		size -=3D sizeof(c);
> +	} while (c !=3D L'\0');
> +
> +	/* Scan file_path_list. */
> +	file_path_list =3D pos;
> +	do {
> +		if (size < sizeof(header))
> +			return false;
> +		header =3D *(const efi_device_path_protocol_t *)pos;
> +		if (header.length < sizeof(header))
> +			return false;
> +		if (size < header.length)
> +			return false;
> +		pos +=3D header.length;
> +		size -=3D header.length;
> +	} while ((header.type !=3D EFI_DEV_END_PATH && header.type !=3D
> EFI_DEV_END_PATH2) ||
> +		 (header.sub_type !=3D EFI_DEV_END_ENTIRE));
> +	if (pos !=3D (const void *)file_path_list + src->file_path_list_length)
> +		return false;
> +
> +	dest->attributes =3D src->attributes;
> +	dest->file_path_list_length =3D src->file_path_list_length;
> +	dest->description =3D description;
> +	dest->file_path_list =3D file_path_list;
> +	dest->optional_data_size =3D size;
> +	dest->optional_data =3D size ? pos : NULL;
> +
> +	return true;
> +}
> +
> +/*
> + * At least some versions of Dell firmware pass the entire contents of t=
he
> + * Boot#### variable, i.e. the EFI_LOAD_OPTION descriptor, rather than j=
ust
> the
> + * OptionalData field.
> + *
> + * Detect this case and extract OptionalData.
> + */
> +void efi_apply_loadoptions_quirk(const void **load_options, int
> *load_options_size)
> +{
> +	const efi_load_option_t *load_option =3D *load_options;
> +	efi_load_option_unpacked_t load_option_unpacked;
> +
> +	if (!IS_ENABLED(CONFIG_X86))
> +		return;
> +	if (!load_option)
> +		return;
> +	if (*load_options_size < sizeof(*load_option))
> +		return;
> +	if ((load_option->attributes & ~EFI_LOAD_OPTION_BOOT_MASK) !=3D 0)
> +		return;
> +
> +	if (!efi_load_option_unpack(&load_option_unpacked, load_option,
> *load_options_size))
> +		return;
> +

In case this was ever to be attributed to a cause for someone to fail to
boot, it may be useful to drop a pr_debug here that could be easily turned
on.

> +	*load_options =3D load_option_unpacked.optional_data;
> +	*load_options_size =3D load_option_unpacked.optional_data_size;
> +}
> +
>  /*
>   * Convert the unicode UEFI command line to ASCII to pass to kernel.
>   * Size of memory allocated return in *cmd_line_len.
> @@ -247,12 +341,15 @@ char *efi_convert_cmdline(efi_loaded_image_t *image=
, int
> *cmd_line_len)
>  {
>  	const u16 *s2;
>  	unsigned long cmdline_addr =3D 0;
> -	int options_chars =3D efi_table_attr(image, load_options_size) / 2;
> +	int options_chars =3D efi_table_attr(image, load_options_size);
>  	const u16 *options =3D efi_table_attr(image, load_options);
>  	int options_bytes =3D 0, safe_options_bytes =3D 0;  /* UTF-8 bytes */
>  	bool in_quote =3D false;
>  	efi_status_t status;
>=20
> +	efi_apply_loadoptions_quirk((const void **)&options, &options_chars);
> +	options_chars /=3D sizeof(*options);
> +
>  	if (options) {
>  		s2 =3D options;
>  		while (options_bytes < COMMAND_LINE_SIZE && options_chars--) {
> diff --git a/drivers/firmware/efi/libstub/efistub.h
> b/drivers/firmware/efi/libstub/efistub.h
> index 85050f5a1b28..589d07acb22d 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -688,6 +688,35 @@ union efi_load_file_protocol {
>  	} mixed_mode;
>  };
>=20
> +typedef struct {
> +	u32 attributes;
> +	u16 file_path_list_length;
> +	u8 variable_data[];
> +	// efi_char16_t description[];
> +	// efi_device_path_protocol_t file_path_list[];
> +	// u8 optional_data[];
> +} __packed efi_load_option_t;
> +
> +#define EFI_LOAD_OPTION_ACTIVE		0x0001U
> +#define EFI_LOAD_OPTION_FORCE_RECONNECT	0x0002U
> +#define EFI_LOAD_OPTION_HIDDEN		0x0008U
> +#define EFI_LOAD_OPTION_CATEGORY	0x1f00U
> +#define   EFI_LOAD_OPTION_CATEGORY_BOOT	0x0000U
> +#define   EFI_LOAD_OPTION_CATEGORY_APP	0x0100U
> +
> +#define EFI_LOAD_OPTION_BOOT_MASK \
> +	(EFI_LOAD_OPTION_ACTIVE|EFI_LOAD_OPTION_HIDDEN|EFI_LOAD_OPTION_CATEGORY=
)
> +#define EFI_LOAD_OPTION_MASK
> (EFI_LOAD_OPTION_FORCE_RECONNECT|EFI_LOAD_OPTION_BOOT_MASK)
> +
> +typedef struct {
> +	u32 attributes;
> +	u16 file_path_list_length;
> +	const efi_char16_t *description;
> +	const efi_device_path_protocol_t *file_path_list;
> +	size_t optional_data_size;
> +	const void *optional_data;
> +} efi_load_option_unpacked_t;
> +
>  void efi_pci_disable_bridge_busmaster(void);
>=20
>  typedef efi_status_t (*efi_exit_boot_map_processing)(
> @@ -730,6 +759,8 @@ __printf(1, 2) int efi_printk(char const *fmt, ...);
>=20
>  void efi_free(unsigned long size, unsigned long addr);
>=20
> +void efi_apply_loadoptions_quirk(const void **load_options, int
> *load_options_size);
> +
>  char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len);
>=20
>  efi_status_t efi_get_memory_map(struct efi_boot_memmap *map);
> diff --git a/drivers/firmware/efi/libstub/file.c
> b/drivers/firmware/efi/libstub/file.c
> index 630caa6b1f4c..4e81c6077188 100644
> --- a/drivers/firmware/efi/libstub/file.c
> +++ b/drivers/firmware/efi/libstub/file.c
> @@ -136,7 +136,7 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t
> *image,
>  				  unsigned long *load_size)
>  {
>  	const efi_char16_t *cmdline =3D image->load_options;
> -	int cmdline_len =3D image->load_options_size / 2;
> +	int cmdline_len =3D image->load_options_size;
>  	unsigned long efi_chunk_size =3D ULONG_MAX;
>  	efi_file_protocol_t *volume =3D NULL;
>  	efi_file_protocol_t *file;
> @@ -148,6 +148,9 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t
> *image,
>  	if (!load_addr || !load_size)
>  		return EFI_INVALID_PARAMETER;
>=20
> +	efi_apply_loadoptions_quirk((const void **)&cmdline, &cmdline_len);
> +	cmdline_len /=3D sizeof(*cmdline);
> +
>  	if (IS_ENABLED(CONFIG_X86) && !efi_nochunk)
>  		efi_chunk_size =3D EFI_READ_CHUNK_SIZE;
>=20
> --
> 2.26.2


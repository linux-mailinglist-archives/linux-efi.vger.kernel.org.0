Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBAB605E3A
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 12:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJTKyM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 06:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJTKyL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 06:54:11 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2045.outbound.protection.outlook.com [40.92.103.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546851DED79;
        Thu, 20 Oct 2022 03:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0BVxf0wO8/F/AqP8pcbgpFIHLFwnZsLc38Sqrmcomz3Iax2AeLpIyPOgUDEosVSGkUAwUVpOaQ8JDzWWAN+L4jUxSBnoBjVS/ytbawlvlxuIVL+IlX+BUZYDBMvhyF+i/XF8gK7jTQTLEHqfpFfnUCAP9+BC5P8ax+tQ6K0m8MoqyyqoJeHAmGRTT/3z8kMEirveMdJs8EFAnBiUO8TOYAu9lVRp4k8jjy+7Qo+e0Ck8lXKx8rNZx41aFl9boZllk8z5x9klg8H2hV9V/InMWI/kTD25PH7JclqzrJV9z0SIU+R3v/bQU85ceh/Ou55/fVUsahKOcGiZaaDULOniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPdoY822CpO8VSLl1ks731zySDDkY/p1apilx5+uFTs=;
 b=VdEaZzpUfJK+sWomGIjWONXH/CLmbd6BZdqGRzDQhZ4tQQC0iVBu0XcLxnkCWSFaIJOoG01pzwSu1vb5/pq4MwjsIqSG/v9Nvovoitt2+qEIIhNvJ5SU/DJ3NS5p6rA+7ZPJkHrgdZI/i7DDottv3WRg2VhgoCfK4pymqQ8iEF/UNfHYve55VH+Hvb7haSKbG56fPMw9SJrKKyMeLv6mxJWBovzwvmJiu+J6w+HWDbxFhsWTKkz/85ZAGuCN9BboKlmugeodbVpJ1M6S76r3YEh3y+hTL5M4GTQUNUgYLuEujEqBBGbZVp0QVNiFkIc8Igl59K1tCBmA4HDirT8Irw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPdoY822CpO8VSLl1ks731zySDDkY/p1apilx5+uFTs=;
 b=R0uCeSVU0mZc/7YaTXaMwhq9qkbSuGlah6KAL2UURkpGO/4KLvIDyaJwVryFTAYCxeAuZk5yA80nFPovp4i+pmBxwRTCmSDBjCmEDQ2q4m3/pNGSoqsQ57Rp7ie6qOaR9yYcXGfjbbSJM7s+LXA03UE66WXRjTcYVmQDOsEZX2vJ/9vspRNmS2y163o6VDx5qVWCdySSewi0jMynZTmVGu8P+cc429h8QFNKiFJxsxrcwlfh3nGjG1VAPBq/K6lvAkUr6m1NjE6ynyDxeXqnqWT0gvqw3TSkGwBe05w0V9q40YrjOJTH+s39AdCGrORqNfxX6G6p5kfkvzxrcIxHQw==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 MA0PR01MB5866.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:6f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.34; Thu, 20 Oct 2022 10:54:05 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::3dc1:f6bc:49e4:b294]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::3dc1:f6bc:49e4:b294%9]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 10:54:05 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>,
        "jk@ozlabs.org" <jk@ozlabs.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [REGRESSION] Failure to write the NVRAM variables starting from
 kernel 6.0 on T2 Macs
Thread-Topic: [REGRESSION] Failure to write the NVRAM variables starting from
 kernel 6.0 on T2 Macs
Thread-Index: AQHY4/Chn/t4Wu6acU6x14mE2JkbVq4WOgwAgADinAA=
Date:   Thu, 20 Oct 2022 10:54:05 +0000
Message-ID: <E59CCD93-C6F2-4A78-89F7-9F2244C9AB97@live.com>
References: <23DC077F-69DF-402C-A940-2E7EEABF2D97@live.com>
 <CAMj1kXG03-0AdM_ROf2UhH-N2Z52v7ox_emSQw=y5p3sMeTrMA@mail.gmail.com>
In-Reply-To: <CAMj1kXG03-0AdM_ROf2UhH-N2Z52v7ox_emSQw=y5p3sMeTrMA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [2+pP6O3j0bsIvcQ6qSIwwO6j1rneeC76]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|MA0PR01MB5866:EE_
x-ms-office365-filtering-correlation-id: 9bbf5be6-84cf-427a-2dee-08dab2896831
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1AnkMEuHjiXwFjEAxx9391OkBLbOK6H8W3mk296SU9HWZQ2uU14cMEtKw+o6DRwPJRFNgHqGsxth8u694rqtoa5AQBns+Me/qnB65CDN8JwLzQ6LLC/QEakJu0HrL9zV/YMIeZoSTEcol48/VGVABBRgQniXxzQSl1DvANyl4Zflbp4be3wnRvkEdqY7tuqGjTklPcZF6wRYCfdlUGPlc+6WnVDPXS8FGcZArQI9TNmmArjJpoBqSUw/yjmobUtgl/ES/CdUlDh38XTgtK9BZQdSejtz5XiSsJ1nGqsNJbH6BvmlXCKi9DWkZ0f3dFTTXnmEOK2DbtQbUJyI33AdzgFkpJdsM72gaJgsD6XyfsKk76hqmowGgRHzo9Os2ehzmyY/hB5divYtY402M8GfKhYK+dEXtkJd/NYCVlZ56nLSSKLQXJ8DLUAlVhMqtO+2Sxm31VK45K3LL05nbWxQro5pqXaYH4TbqtOZ6HcTI8SdPKWwhFVQQ926VHz8r1TPb9ySXGt0YElhg4ParzlMnWaf7/QDoE0w+Aw127iY8zW8lFNl7biIn+CzCIRqgcpCdOHnfm9Kl4w280VWCJYNfZDJ4IO++/4ehJM210zLc4QKiKY8IrZP18HelndL1GhkoUV/6qoBljNw2l1dmu9k7YkHL5aKUL0A8CcPWde4eI/Huu+Qw/RqRVwo4iyY229Q
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KMaRt9NsaHh4YXArv54QUwPN6CKCB+rmSrwdKiFUzAcujqD+VvYMdPmvpU95?=
 =?us-ascii?Q?PnwgeVups92QHC9qAZ/ezMN3VtTQa/6Esns3OuoaNYBN61ph7iKwBnBVDtCt?=
 =?us-ascii?Q?C/eKV9HAinf8dlBaxi6akI5q0ziFspkXpe5m8imhjHe+rbAKuyhc8GMnfA34?=
 =?us-ascii?Q?wqfiffuahLTLxoJRYXOcUSCehW18Kzt1iFIOPtsjUi12fXx+EyJV8wHEW6YI?=
 =?us-ascii?Q?L+J0cIQhLoHF5gK1A3GEgauYgPD4X7yRrOTqz8AdoKcekPxQqhJxPi2ymZ3A?=
 =?us-ascii?Q?Db/ytfld2I4YSwanPZCzhbnLnCDu0XPz6ZTp5ID2nVEDvTJT1aF3jAyZ4hz2?=
 =?us-ascii?Q?u1R+KhJp7AjZNYQBw2z9NjiB1+ru4TJDRhXD0D2FmLwghq6lAMEFhZSFNPWq?=
 =?us-ascii?Q?ast5veBrNWe7VF9tvv7hLjcN0BX/lsP8AZyQlBe4WYfrJ8saDhDDpheN/KGV?=
 =?us-ascii?Q?0ZdSHTB/u6szyiHbBf4l5a6hqasGEO6BFl2jfaD2Hl1gttPgTqfXzb//pZ2G?=
 =?us-ascii?Q?qdhwlXK7GNRFLX/90gyIvfUFErl/9Ke7JyvAvL5h3DHHf6wSCXsj8jqAv3cL?=
 =?us-ascii?Q?BtEQAAiilJZEmYRaWs/Z01B6/YEpc5IZoUjbT/DD3KPaMvXerG8bg3iX9FfQ?=
 =?us-ascii?Q?cA07v2xi2tkzjyefCoCGODrT7Up2u4u3hJCx8w0vzv+kcwcV7tHqY6OsO8Fq?=
 =?us-ascii?Q?rU0d04WxdXATNRW7liGR5Bq9LTSfw288U+vlXqoiAGs+MMHb8XNFAMsy3CL0?=
 =?us-ascii?Q?3lDNZRMXVsJXmZt3+msiSbMU9CSEVcs2Xsz+GRSzs5ewmxIrvDU09288BBCA?=
 =?us-ascii?Q?MnjeXQIrGa/+QdSMRTwj2gIOL5hgm8ODZLYgbwivCoxD/aoWcYcee5Lw/LbP?=
 =?us-ascii?Q?VkfD2vZY4k8YNMnTlSI6lj5OFOA2gFx1tctF4lMxB2qAu3IxAHNkZ+ShsrRE?=
 =?us-ascii?Q?rIiSr4OO2OSqIE5VW5PXbT9AAyJkfmMNqZgbzO7sGa8/ISRDu2LvS6SWSOdN?=
 =?us-ascii?Q?FQDf9CFo2+vy+hWUOMRXWPb63Dn0DUL3tUdOQnzUqLlLbF27YtwqpiaGGUWz?=
 =?us-ascii?Q?JPL367DhWdpq+sEMC2EG19UKj7FUPog4bLLmfgSHG3qXuRqo4OGU6+OU7pEi?=
 =?us-ascii?Q?nV35ze8Hhi/Z0dlyUPSlxnCKMz9x5GZwyZMkEJwLV62Y/djfciqGDdbywt8l?=
 =?us-ascii?Q?H938IT4I6L3SH5l8zOdoQGwc6UmBwSJ8AQX9EMlR0llTVq3E8UDcAoousyqO?=
 =?us-ascii?Q?SCvZ/055COoOwVzNfykTnS+gUFDwrbKu6WUj7Bf/fQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A5269247AF865E4B861CE308EC5C6A6E@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbf5be6-84cf-427a-2dee-08dab2896831
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 10:54:05.4038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5866
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard

> On 20-Oct-2022, at 2:53 AM, Ard Biesheuvel <ardb@kernel.org> wrote:
>=20
> Hello Aditya
>=20
> Thanks for the report. I did identify an issue in some refactoring
> work of the efivars layer that went into 6.0
>=20
> Can you please check whether the change below fixes the issue for you?

The patch given below fixes the issue for me.

>=20
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index dd74d2ad3184..35edba93cf14 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -209,7 +209,7 @@ efivar_set_variable_blocking(efi_char16_t *name,
> efi_guid_t *vendor,
>        if (data_size > 0) {
>                status =3D check_var_size(attr, data_size +
>                                              ucs2_strsize(name, 1024));
> -               if (status !=3D EFI_SUCCESS)
> +               if (status !=3D EFI_SUCCESS && status !=3D EFI_UNSUPPORTE=
D)
>                        return status;
>        }
>        return __efivars->ops->set_variable(name, vendor, attr,
> data_size, data);
> @@ -242,7 +242,7 @@ efi_status_t
> efivar_set_variable_locked(efi_char16_t *name, efi_guid_t *vendor,
>        if (data_size > 0) {
>                status =3D check_var_size_nonblocking(attr, data_size +
>=20
> ucs2_strsize(name, 1024));
> -               if (status !=3D EFI_SUCCESS)
> +               if (status !=3D EFI_SUCCESS && status !=3D EFI_UNSUPPORTE=
D)
>                        return status;
>        }
>        return setvar(name, vendor, attr, data_size, data);

Thanks
Aditya

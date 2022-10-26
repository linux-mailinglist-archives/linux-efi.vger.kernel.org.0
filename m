Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DDB60EABE
	for <lists+linux-efi@lfdr.de>; Wed, 26 Oct 2022 23:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiJZVSS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Oct 2022 17:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJZVSQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Oct 2022 17:18:16 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2080.outbound.protection.outlook.com [40.92.103.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE6C10CFBC;
        Wed, 26 Oct 2022 14:18:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRcj8ls7sCH6GQXTFBZWtLOpDH8IxUJXoPyqvXlr1BqsuEJNv8EUw6XnnhZjMYROVKqzki67FJZIg3r+gWE2UT5qXMryhpDxni2IWGIHavYzWKrbTIE0dqyhjZKFLIxILGVsC2kGeR9Gk+9Nd8eVj1DJDguArw/1YOLAKG0a7he1Z0d4ALuJLfKHnwUhLRMFSlLhkdYeRf+bOvLYmeFK00R+2l1uSjNW+MB1Q90syyFX+5gawQYGRmqjKsVR+rK+2jA9eI6gr82exbkIs6Euhlts3V9XC6LupDLQtwfC9Uk+Kecl3C9D44HNFu3v/fYoEfqOiiKFskM0yFhc55i8eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcpO60ngSJpMUkE2p6hTvbZzYnJFeV01eJ6YL4YQflE=;
 b=dGyJaXfxLfRzkDq5CEQV2yZPxMibvo2B07XRMZP7eKAgcsyuu+XdbcX3DCqjr/1nM4v3sb0/y+uxjpjrfB4INDUiIhkLUk7I9k4OQ+Q8BuTYiKK34S0onoWpmc7dFCmnDq7mRjbvHrHaqipJFImbV/0QXiLu1BoUxHKoFdk+rAefmExGACDLtcJqJOc3BXPRUgc3r6ZWaBfiB5m1o9L0UdAf5V8TxECx98q36lpvt+0+Rs/ty5EZEvZ4okJEWD6W35J1NbVPCVU6KAe8ngIHPDcn2r9p39uEcZVv0Yq5uuo0LeKu09Ma+RFBu7KZwM2sK1fKhmXDXOaSv9CkK0c95Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcpO60ngSJpMUkE2p6hTvbZzYnJFeV01eJ6YL4YQflE=;
 b=HKqTDgiL5iOi6k6Jt5gYclqFr9fjgpgvYFRqDI3fZfeYRgRcr0bh/4EQ5RepyLY38qUTc6zBJ2X4RF72hmgI2ar/wCZChOVEgFlByDsPFNoubkdcBboduBE70t9B9mOv/9kZ29exfy9XwyNC/ijGuE5DMrpirQzpkJL5wHkdvbH9ztzb73C9oa5VtjMlfLA70ksZFecLY0Mh2ArIOT5/H6G+VJA/knEUn18OWBfJghFU1ZozN6tHXMli01AolQAnsllowhmNXNdkfMyNmHZ7VUJGJgw7gSFbAAwF3BiWy4b2urpYnJ6FjBug7tjIpQuMpfD1gGfIdq4v7Ty++YRKAw==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 MA0PR01MB7284.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:38::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.28; Wed, 26 Oct 2022 21:18:06 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::3dc1:f6bc:49e4:b294]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::3dc1:f6bc:49e4:b294%9]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 21:18:06 +0000
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
Thread-Index: AQHY4/Chn/t4Wu6acU6x14mE2JkbVq4WOgwAgAr+4AA=
Date:   Wed, 26 Oct 2022 21:18:06 +0000
Message-ID: <E48DD0F8-D9C5-4BD2-87A9-CFF0C22D0447@live.com>
References: <23DC077F-69DF-402C-A940-2E7EEABF2D97@live.com>
 <CAMj1kXG03-0AdM_ROf2UhH-N2Z52v7ox_emSQw=y5p3sMeTrMA@mail.gmail.com>
In-Reply-To: <CAMj1kXG03-0AdM_ROf2UhH-N2Z52v7ox_emSQw=y5p3sMeTrMA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [l18NDBQ5YC21gsgqo8EIuZXwRVRHnpsK]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|MA0PR01MB7284:EE_
x-ms-office365-filtering-correlation-id: 4d605792-8494-41fe-aad9-08dab7979318
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ctUKUg7MSi7sAFKk82cu8P3PxGYSp064ygqp7KcdFYPci6ExBsSxTTLFu3VSt4y6XiJ/sCu2BuXS4jFZKAQB1GLibVJraSSVzI1f5NGPEy+chLMftu9tDJ1RIaAn5J+Yy/D98pvliAzi3PO8EtrxnJKQ8o5+SGFcVKbJ3lTjbQ0+q1O/4GrkfUhZZUia4Z7WUJ+JMBJ2+OQ72uV+gV0zAIQvBY+IvxHUJ736RvYxD6MUCUL1Ip6DA+ah7QJvktLiZlXjK+J0ZFrg4eEbFrbnc+BzuCiAt/mHah/gzWgIG6re1yTNo3s3M1vFnoOouNOAnFkQiNdv8mi/Q2nIvTWHh2n97jeaYGjktUTsjsZtD913+Uhb6sbza8/swlo+Lulqj8rsNqSZ35PlilRgSyIvSiXZD63Qxsb1R+QTTxG5xNEC7W7N163K95BLnOtz9IEq8OOi86bqmlXW4B0vdHTWVgxuPL8NxFaOdxw13pzYw6B9aA/TKp9q0e4nvMAHFYEna7KAmNjJOPt50s8M1OY5QJkyvIOQ0CBR0/DFvcC8PO62FxiVB9kdBDUyi0OoNCNPyDfkb0BF8+bOwQaOvtaG0P2v7yluxCeN9c3DlevYz/D3BKwZ3fPUbtulVxpd7VvhZvNdqmPzsPEdUr+4thlCpKcX/3cT3KuI+cS5/SmPuXcKQxehTOG0E1wQDKsagBzF
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EBbjmEhSo2QFZzu6OBImx5uXPYnDL4YKcN543dhyScbo2v1WEMmBDg9oeKA9?=
 =?us-ascii?Q?z+tBeZX2Pw9c9fX63N1Y0/JmLeTubVASBnCI4qBkbPgQmMg8ltj4+0wtagox?=
 =?us-ascii?Q?IlfJBiVIYQm4X/OuDAPJ5nno/eGVR8R02biC3eB6hJkywpmz/f7MAF0KfTYQ?=
 =?us-ascii?Q?/0+1pgi3Oyrzj2zS/GIbl4gnWpo+EOsofVyaIueQDQbcni2dRmBQOqBqo8j+?=
 =?us-ascii?Q?DDr6CaGacC4SmZFrZ6AVAgxnfflw9XGNOy61lh4ZUt6kpQfG17CGFg7cCBNY?=
 =?us-ascii?Q?nuJZCu/3k+DCEFYsZVNrpQ53Igww+mEyrzXbY1mCqtyGGxKKOo5MSLb7fLq4?=
 =?us-ascii?Q?DSJkQQtUlPSqdOwTkashGTxs3dxkm5PENhaykiVQOZXoAeMlNbwDHdPa+AxS?=
 =?us-ascii?Q?Fwx6B1rTRVVUSYsV6bQYeP0B6SyVloh3+6Bner75CeQXOcYWQHL+EvUNbuRd?=
 =?us-ascii?Q?WMfXX52gyckIBAtUvrKAzwvKaYNMtw+zJNjmA0ZALNTaRcB7xvp4djgdNf21?=
 =?us-ascii?Q?/Tsze/XsWuij7tEjSkDWLP28rkGN9EfklgX1lZdILYDaBaTDDOcZNpHw7OJo?=
 =?us-ascii?Q?5U9SgibUfQRC+VFYdRgPRk6J7skD3EjH5QFKwcZ2lAJ82NYg6oA8/ZD+O1j+?=
 =?us-ascii?Q?J0+J6SqwO29iOBZ6r+Y+x5Ij2E661mLlU6Zc+pB41heruKpb9UivGggxjiyM?=
 =?us-ascii?Q?FOe8ONbK+e2/V6EO6bFlgjr8qHdZgy1OiHVdtx+Jw74qh1as1Apn92aT/8nv?=
 =?us-ascii?Q?1SCAFYhVK7K5MTfwMOQTemyE4922kNyCHqo0fLXLCH7puPC4koNzec2iiXLA?=
 =?us-ascii?Q?Cu9XuqDYEQ+PtXJrcUhcMAcjByILqnio+IKMeBAzDbm5kabIkM1J+7nfUePV?=
 =?us-ascii?Q?4yBo+SbUQhidTd01gkcbeumIlGmw+nPBMMDMCwHpD2Np9vHG5Ii/3lulSzQN?=
 =?us-ascii?Q?YvoA8M5yHffWxl3L3aSrn6Xepdf+hUktvLyjt1XtDV9nRsSZ0Fzqkvzr2zk4?=
 =?us-ascii?Q?Votdtu/UMagg5oehlV8zdA0WmKUAwEufJwqxOXZaqI8nfNWtzCaVwYAo4lOd?=
 =?us-ascii?Q?1kX2NTTNbTcMU4j+lwbLFShxIyc2LN8uVwKFuMRAObddPqeZkpRko56FMMLX?=
 =?us-ascii?Q?HIPm8m4w9RSycDO2mKyyH/W7AP780FyqgHLr+stQV58jZVKIANkpP5q0QM6L?=
 =?us-ascii?Q?3ekLlgQEPotHv58x4ytrJLxu7MslGL1Ko/40kaTTPBogM+Xnx01KfTQfhCaj?=
 =?us-ascii?Q?CmkOPjzTEa1fGDTHzpgCuW1Sai5QfG8MxWWXX6I+HA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E10AC3FF92DC0F4292FA7B31F181922C@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d605792-8494-41fe-aad9-08dab7979318
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 21:18:06.1846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7284
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

Just a friendly reminder to get updates on the patch you asked me to test, =
as it seems to fix my issue.

> Thanks for the report. I did identify an issue in some refactoring
> work of the efivars layer that went into 6.0
>=20
> Can you please check whether the change below fixes the issue for you?
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

Regards
Aditya=

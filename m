Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA31611123
	for <lists+linux-efi@lfdr.de>; Fri, 28 Oct 2022 14:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJ1MWE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Oct 2022 08:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiJ1MVu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Oct 2022 08:21:50 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2096.outbound.protection.outlook.com [40.92.103.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD591C841B
        for <linux-efi@vger.kernel.org>; Fri, 28 Oct 2022 05:21:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aX2IVbfNj++YYie2ErWgQl6nr/US4v3AIm/iP91VVbyYEKEQGVmZKMHjnNoULo6A3XbkMYRSLU6NHTtq48vBKYklVRymnpiHmi15f2L7KdWAf84EbjQrFOGWYuETK6WNkvaWT8JjOJg09uchmlvKf4u2BayC0qaoQv4sMM+qTSUn/4Me15PiSu7VJZ4HlSb0SU1OgwenxEfMMDaAvRGg17VxtlS2vrZkdORdymZRelposhB/5mmA4OCKBQDIzKyX9rdbbZLmbApdSZueX4Z64dXwH+OfCQVeH04CUp+PtxQmIs0ww8dpdVAAbT3oAJgDRXk40C4ypULkQQ/5L4W56Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01+txiRC4jv1UtUeQPa8JENvUI39rBeHvc8xdssBUzY=;
 b=A2qTqAbSBdNnfPlln08NycoIiPRdhk34WARyg7GSt/fSLzCt5bhnH2kH1aRpihEttIP7SvMrDAsJCM8SQ4mY/CN3BoG+nycI3WM5Y3uCpZNFdoFSPvAovpQv3SLp9og4/DlSfeW1RyqJ6cTNeSxNZ5HvYRuZwR2YxnL/BdGRblLUPx2jS+zJFgMP+xcemDdeCjqKkCwR9zpp4ZevHknDsumC34lbF6TvlON3SCGN7QcWe0k1zfyQ47s//Kyw7jVQMkJi08X9ADuChGloTXSWndO/uh1K6IesLp8LP5zSCXjN51v9SJJlk8H97d9q5jx6L3uTPsXzOKXov2uK0oEWKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01+txiRC4jv1UtUeQPa8JENvUI39rBeHvc8xdssBUzY=;
 b=HvRrVdzNUNv9GuzWYmI7bRXqeibWlDSEV3imJXPw50lcQ6sYX+jum/MaYUny2SM/Dof04QTXHzibSB+m+ogRTFMp1zESMxaNvYy1lLTQqQTRXZ0M1nhDzAYUjRp9Vkxn3ls0WR9WUx6F/yFs1R5tpoqv2wBzQ+VR3MyQHW0TIyVYXwkzv7g+NWdlVpUJcOBzxetNTSZsAzbHrO++7/EfkHPSgyliYCM3Bby8OsqiUnMb8EdWU2xWl2dtQeiV99YfwZNMHS/GZsW6pPx5KjUmRLZ2Mjv7gAZ3mkiS/5Lir116GHS8zZ1iftXtqAto7zde7kc3P5mV+fnWt5yEhr5icw==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN3PR01MB5518.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:79::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.28; Fri, 28 Oct 2022 12:21:45 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::3dc1:f6bc:49e4:b294]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::3dc1:f6bc:49e4:b294%9]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 12:21:45 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: [PATCH] efi: efivars: Fix variable writes with unsupported
 query_variable_store()
Thread-Topic: [PATCH] efi: efivars: Fix variable writes with unsupported
 query_variable_store()
Thread-Index: AQHY6gwlZeVsK+/U20ioJYTuN/T5SK4ju4aA
Date:   Fri, 28 Oct 2022 12:21:45 +0000
Message-ID: <0DE4AE6B-4437-4D5C-BE0E-3FE732EE8000@live.com>
References: <20221027135755.1732339-1-ardb@kernel.org>
In-Reply-To: <20221027135755.1732339-1-ardb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [jMpY12UAcD9gbKbFM2g0NxFBhxosSZ82]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN3PR01MB5518:EE_
x-ms-office365-filtering-correlation-id: f80ca34e-8858-4c80-9c5d-08dab8defa9a
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7SgClwTj3lpJ+4jmf0DHsinfoW+pLky0IWaCyQL3n2j/QDs/hbi5a7kWKwjD+XHgWg+NiuMMEGapt5BuDvQqXksgWzZLexUZmpq+iqLNznan2wvLrf6oIsx0xFj2hZB6G7f7V7ltNZFxlRZItZkaQPhRgqO9xWCbjvEqQsxfhKhIS9kctms9C36wErE7Ax7u7kZQHQ+HtSA/Xdqbh5VnVdc+A6UksowyrHONnbvcnDhq2/P+Cb/GxGmsIoqNwj0kPUPwobzKkFf+2teHXx6/mA5W6mpdkE1lXCTQzJaBcHaCoy6dq06TXPHxDzBhXoYDUqf8xJZhfd8m6C+7opQF8CHIeaTJxH9zIFNXwPn4K4vvmLcPB0MVJm4zwlUKnhVp74rdYCokol7+HItg6aPcghWUv4aA/9qcQsLvAkC33b2FGu+0cV0LCJOijphqdw+Z6HiPWwUQ69uNW6nTTCHx/HxszjrbwyTutvLI9ccOgJ/eRKoMnQO73F1E/eLzLATzo8V9bHQiXr4iad++7aHsan7knBcAWCX+Vb3cVHs62I+z8k8SERHy0Vu/AkqlZ8wTrlMeKvkRQaWGOAKOtPTVI9F3C7ZEfJKIFStx8u94c/92etguMfdKpZ9nisithkeajUjfJZcQIJ1FxDHF1rGxOtQL+vYk6QtRyhpQMTLj6vypVUjag5YfQQtj4YHNVCaT
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bOBxbSDEcnqZLgC/XkvWoQlh2l9tmH0yHfxCwSeonZDDJPPoLGAjmj8yZ+/U?=
 =?us-ascii?Q?l6Z6XWDrIqAcX1S9yvyRtCXKuw1MZPHfpLX9ZV30UUm29XE/AzH7Yh3GYdz0?=
 =?us-ascii?Q?8YVRH6v2cguVmdQsHyKBXRlKYVxhElrAQLhzigCw0QdJvWkGMQYG6/X5PYSs?=
 =?us-ascii?Q?zAlnYuuWddPvr7jxZ1Ynp2h3oUdsjA8M1VaAiH6sTAF0T+0XUOW7uwwk9UW/?=
 =?us-ascii?Q?InydnQO0XM83/WektvLjge6cMICPr8FzeDKbZ8IKSKwrS9vslXYgRm7Rdbqu?=
 =?us-ascii?Q?3RQ22+tJG19TAzdPRlJCopcvOSqolhXQtXUcv4rr2jAsjc+awdkoblZV8LnD?=
 =?us-ascii?Q?ZZVTCmMNCbpRGyi6FEYeRZPb0YDXl0D07aCoaS93JraiY4KvMA+s3MiBLbkr?=
 =?us-ascii?Q?7sddtUjjTCNpt5DHx1pvHk+tHlrYUwASJSQ/12jM26Fbiw+/QbCwFNjLKR1U?=
 =?us-ascii?Q?4E482K/jVt7j9wa/P4mrIMIiyRizXdTICf6NbwyLDv+ubucvqDwkxBwwK0s0?=
 =?us-ascii?Q?DLm9ijt8Yy5Rx6xltBwqNAWUos3v5Wend40SUYtQbnrIaLTMn3UVusmtIC2d?=
 =?us-ascii?Q?chl2IqC3Xbi0IhgulgtLK09tiikryb/9ak4vuVc2DL0Pf1L1Tmfees7KxHLg?=
 =?us-ascii?Q?jEqK+4hgcjR9X3fgBtIc2U27seUX8zBiJ0H/3RXOGUDWr4OmkX5mPxKJhLNk?=
 =?us-ascii?Q?Xh7Bd3YaRvrhIwhqmmPvB1bcR12ron17HemlMaHwQS1fcpAODyxCI/cKkbKY?=
 =?us-ascii?Q?5fDTp8FREdi1EBYknE3z9yT8T47s9DStcrDcfi4Q6DbQ+9MokKG4s0Xmx2gp?=
 =?us-ascii?Q?61QXVombarPuAr4+28iKd6mc4jm/s1mqcCqBo8V5MTkEAJbCFz3zCkMDOARz?=
 =?us-ascii?Q?S5XOBXJmMZKn/RTQH4u/AC4y+3vHuDwmeYa6JQeYddp4lrTXZwUUq4aSQy9D?=
 =?us-ascii?Q?5oJqOnrs5FnnOdQAPDMGUkxScbiyBIokGebg7RorQIi7ZXMaNZRYmKVb/4w4?=
 =?us-ascii?Q?FlgqMB7Ly00qOiR3KsU+WrU9Ef9eymP3FmvpgnRxGhxBUoqjH8UVsWH+ww5g?=
 =?us-ascii?Q?yrzb+71XgRn2VQtiAGqK0WKla0WF35/J5scfA/EBaayXmApE+zWVWkteskVf?=
 =?us-ascii?Q?dne86/ztfoKXwpteaOlQKdgOHdCWXnO621zjgL30im0m3zkDvy16H7fjXfzb?=
 =?us-ascii?Q?6LdKJMfkh+4RrXKoImGlT9MS5fpEJythObX6Slo+a52kkxk+fHUkmC9DtnY5?=
 =?us-ascii?Q?GUWQ/LQMdzY+1LYrILiD+/eNOcBI+VwhE+NVz58O7w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EF38F5359430FD499340B3B49B78A8A5@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f80ca34e-8858-4c80-9c5d-08dab8defa9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 12:21:45.2877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB5518
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



Hi Ard

This patch you sent fixed my issue!

> On 27-Oct-2022, at 7:27 PM, Ard Biesheuvel <ardb@kernel.org> wrote:
>=20
> Commit 8a254d90a775 ("efi: efivars: Fix variable writes without
> query_variable_store()") addressed an issue that was introduced during
> the EFI variable store refactor, where alternative implementations of
> the efivars layer that lacked query_variable_store() would no longer
> work.
>=20
> Unfortunately, there is another case to consider here, which was missed:
> if the efivars layer is backed by the EFI runtime services as usual, but
> the EFI implementation predates the introduction of QueryVariableInfo(),
> we will return EFI_UNSUPPORTED, and this is no longer being dealt with
> correctly.
>=20
> So let's fix this, and while at it, clean up the code a bit, by merging
> the check_var_size() routines as well as their callers.
>=20

Thanks
Aditya

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F9A60505C
	for <lists+linux-efi@lfdr.de>; Wed, 19 Oct 2022 21:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJST0L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Oct 2022 15:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJST0K (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Oct 2022 15:26:10 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2034.outbound.protection.outlook.com [40.92.102.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79277181DB9;
        Wed, 19 Oct 2022 12:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7hkAcFOwTh0NVpiZ+ZzYc68T0IfRiOaBtZHHk6Gdi2PpTbmFZtRIcHMy4698zZYCENCc9YlcaGTIzq1eCkfVat/MCoQomq59NXuQulbQw0cxlTTYV9xGMmDelPx9m9osOWZTZ5FF9NvFC4ldmVap/3OU+yPapL7S7jQytydBQK0qV5dxdUiKCxpSp05LvTEMxCc/kZs3FUIyOsieNOQyvY7J904c5jWpPzt4ym+GMDbHvoWXymNShP8R2KpeCyhE2Lw6E/MQ08CGiGS5R0IQvKYuibZNR6RTeHve/kMfpYVO1e1h5p2+yhSftK8rAM2gJ5toQj+bNxsqAk06ZKFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5XaLNmotdWE3BQbN1yiUY+FhMRz1uWfELTUwuob4xU=;
 b=a+aRYNJTEcsAXIQU24xvdZX5m24kBFBjPIO0PJ6hyxBhwbVmW5fyzO4Xo8w6rfRJJNdkVe85385pjdkPbboKR6fhpNXPyKjHsOJe07PYDfudrx0aXQ94kco1SFiBEjgzKXN469H3cusoDgxxVWona3i2kvbx4ujzjIM+y7V8U3HD74xZmfKpNOE+PlEdXMTkiCotJIwYaYvGl81zATiY+1HEoEypG3kNzG7z4g2rBH3W9f7oSs6qsnpvcwHgr38wz4oCVEuY4o1GzPOQ30kudUBvEPW81T5BAoyPpuAa45//OjoOji3bfyCHaIY/jby+7Q3De7AqXLqwv4ydtXbT/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5XaLNmotdWE3BQbN1yiUY+FhMRz1uWfELTUwuob4xU=;
 b=AB+DvV5tpyfsafhTXALS6hrZ6Vx7PEf2th1IOgYbbPhOT2ksX92gaI6CpHWk5yosKSaPIkB7jUX7KjZfRMy69QxkkpyO45oADdi0slFfCOxY07hmB5RZ/Ekcd1nGLohY8YR3coOGVeE7Un1gMAdt8lT7gLXxIBnX3PbZYI0dCCBdi5t6CJrZcXkeepu9VkcCMDTqVt3gLmOmEjUqiddnt0Vg45HN2R3LXir1lQuFysmxXOfECLwLJTRsA1LcP7s7dGrn6BOOcoONEsYjthscoWusazVIERR41z1B8TYmfxXpsFQTGbuXqmpvNNTZWQNrkXYhgWSYTSzvjjO7VS0bRg==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN3PR01MB7160.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:af::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.35; Wed, 19 Oct 2022 19:26:05 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::3dc1:f6bc:49e4:b294]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::3dc1:f6bc:49e4:b294%9]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 19:26:04 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>,
        "jk@ozlabs.org" <jk@ozlabs.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Orlando Chamberlain <redecorating@protonmail.com>
Subject: [REGRESSION] Failure to write the NVRAM variables starting from
 kernel 6.0 on T2 Macs
Thread-Topic: [REGRESSION] Failure to write the NVRAM variables starting from
 kernel 6.0 on T2 Macs
Thread-Index: AQHY4/Ch2dExxucnNUS1nzrohEnCsQ==
Date:   Wed, 19 Oct 2022 19:26:04 +0000
Message-ID: <23DC077F-69DF-402C-A940-2E7EEABF2D97@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [IeW83puGjwqH0moJ/dJYwgvCCoNn+s3k]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN3PR01MB7160:EE_
x-ms-office365-filtering-correlation-id: 3ebcca6b-491d-4a5f-39b0-08dab207c3d9
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W0eV115S/p6QYCeeFwtxoUh9dIoHuouIF+xBGJHAdlaiUFgQcvoprGkyHrrQ24RDdAFNiFKyezFc7CY79J5v2surYyiG8DErNrPn8v6azQy1meR5PBqeJLpnvr+VwUxa5cGaQXvJjRlFZ+DVAMcwiWrgTKA/xKdeoITacmmhkkSJxCvcLtR3OsH2Q8K+XKzamNcp4fm/MYgsIyS62EUwyD1JVZcowYefSGV0c4VzgzQH/F2VT2kgYARZqqQkH61iVsVuSBaBYW9eifpBTLyZFMcM4hDSlotdgOOqc8lbS1UjIZydGuUUz/+TniiBMJkba8PbAE3GZoliE8ietzo49ajhSTKZIF+0pmHxdRRj54YkISgNTLuKpEZ8EYpIR8zx/Iu1V9DrKpl1ccNFwRHAjfrXI7BOjDMxF8tqvax1XScka2ztf1Xu6iOxMeT2izV0Vq6xZs/GVAqHeTEMyIjOn8mSLKKVxUthwNQz0Fro5uY/qaCkvFIjhVQeGreOie2cjOnOdqjV3Wy2j/d2lhRsepXldltbD09vbbu3tpAScrJdFhowySWbvBpYWBvbkPVk+1qYIQLwyRNjAaMm7R4BCfP+FXjOplnePMnMsotUXCTb7nR7sImLSEU6qRp2MZcl
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?juuMy6AZ6J+KrexlUddQpPFFsk/9CnzETNhrGGr1+BRBg25DDPdRwFp3UoF/?=
 =?us-ascii?Q?CiWT43Fpm7S1VmvG1LEM+OzUp6tnJWPW1K+FTOxdhp8zDsRT/hGl5JBW0WLC?=
 =?us-ascii?Q?ObglreS2iV87CTpLlBsrGIFOdtwaDniQ/K0Jirb88s+zMCHRaJr4QyGL3VJQ?=
 =?us-ascii?Q?RTF4P5Hc/Ke+lTdRU8Gq6hXnEA+tTBhOlz/513xAiNOBZfPwyxajISjny817?=
 =?us-ascii?Q?UbBlElpPVJZB+/d7MmnZS4M+l6/sRaEdp2hzIl8vYnfA+fZDbCZ1x3o8RDeU?=
 =?us-ascii?Q?+rUtJbAXOL5xola6y8DcB7wMkYmw5COne8wvLbl0IxsXU9mwkmA8xnW70iPB?=
 =?us-ascii?Q?mwBnedCgfBa2cKqvL13kbXeCTpT1H46AJoTkKbssHbKEU8kPOuyxUT3BNsI1?=
 =?us-ascii?Q?zqNe7lKjpl+d12tqvL4Af5MNOPbmO2R+j4hfa4+oK7D/EijpPmqG1RtZGhkr?=
 =?us-ascii?Q?u1ZP8R7QCzUD02XNjA5fsIzpDpx8r81kvlTqAy3Nb117SUKOtjrhpgeL+fey?=
 =?us-ascii?Q?r7hpxBwDSOGXq3Ecrswj8z1rk6qeSDeWExafPLojqykijR8s596kmxPLDDO8?=
 =?us-ascii?Q?ESMqM9Ix7zLRSoixJyLKCB8yp5dx3+xHF4Fh8IN+xCR7Z2ZfJLXxK5UtxyGS?=
 =?us-ascii?Q?RDas1Ql31b8pxy9CPA9yJylNlPxEnziMWLoUczXu0b+tJc9BEMnk/fsguIPi?=
 =?us-ascii?Q?xOM+4YQPbF18r7j7hpyFRFo5qla0QvEFU/zZLnDfxXPEklnsFCP8XI5RIbNO?=
 =?us-ascii?Q?HYDkpBPBjTSa7LzhKqgTWyDW0cmMASsQL84505xY1iAUC9Kk8GLBE7RbAjIp?=
 =?us-ascii?Q?5SckJMn4k98g3VDB1iwqakzsMKDhMJpBLz+ZLVsxggGdPqyini8rqsb1fCMa?=
 =?us-ascii?Q?8zl6PiW47iedU97jTyyFjUTKE1V8JO8dXr/4BMTqkQ4Y7h9Egtd4ugg2yVXX?=
 =?us-ascii?Q?jE2Hi6whYRysOx4fODVtyhYVevFVs6hrcvak8zDDhwGdc6LeW427PUwZs0Vm?=
 =?us-ascii?Q?IXS6yr/gqRh/PYHSEGotHCe6mEhm7unx9feY0jT/kuMjhGv2+9GRkr7soF6z?=
 =?us-ascii?Q?Mg1zVWFB4KzMRHWVMF1B7IY1Izr8q6x3Fwvn7arfHK3U3+tZ2+/AkIMgFLoy?=
 =?us-ascii?Q?eIK5cBgPR6nILunv1XzzO6snwwArX/nh2rvY15VLpMLFkubjL9r51kCJODIa?=
 =?us-ascii?Q?tTEb8FLAfvuN7pQDtu16pzV/mrSLkNj9rtHgX9VypXJxN/icajY3vAv3HI2G?=
 =?us-ascii?Q?iYxSacdzGvxdSf9scKwIEy6yiMWzTiuSUaD/I6tcfA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E5344940ED864A4E84B58EC325CBF812@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ebcca6b-491d-4a5f-39b0-08dab207c3d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 19:26:04.6342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7160
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Starting from linux kernel 6.0, the ability to write to the NVRAM has been =
lost on T2 Macs.

This has been observed especially during installation of boot loaders like =
GRUB, causing errors as shown :-

Installing for x86_64-efi platform.
grub-install: warning: Cannot set EFI variable Boot0001.
grub-install: warning: efivarfs_set_variable: writing to fd 7 failed: Inval=
id argument.
grub-install: warning: _efi_set_variable_mode: ops->set_variable() failed: =
Invalid argument.
grub-install: error: failed to register the EFI boot entry: Invalid argumen=
t.

I couldn't find any relevant error in journalctl though, but I still am pos=
ting my journalctl just in case I missed any error.

https://gist.github.com/AdityaGarg8/da7a9a2c891f5b2f68f71dc0d0e77f9a

Regards
Aditya=

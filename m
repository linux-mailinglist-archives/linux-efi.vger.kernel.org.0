Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6771360EF0E
	for <lists+linux-efi@lfdr.de>; Thu, 27 Oct 2022 06:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiJ0Ed0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Oct 2022 00:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiJ0EdZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 27 Oct 2022 00:33:25 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2101.outbound.protection.outlook.com [40.92.102.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EE3149DC4;
        Wed, 26 Oct 2022 21:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N88RsfssRzMneH4WFr8SDDmSdEtgB186jhtSDp2kcc1nvBWqFpK/n7EsSRWn3RuiBRuDLJ+Z8m3LhrT/D/EnfzzlBQxlSYuNeFNjdl+bqotMWuw1Uf6l4Mr8e/2QeUuisJ5QvqQyddqYicN29SVaNeE8D3eQg8ouun5+MICksJXGl2PLqzXYqv2Uoo1lNeTcm1VwSzqF0MLvT9au0GSygJ6cO0hNhL0C/lpbacTs76JF2D7dY2F/hcgOmeofxxs5nYucSUAD42uMia0qIiiDOx0ga5OP+4L02YRa/L6HRJxeryEGLLODeOtrkX1ZDSFgjpkVm8wNwvmEF/AXHGtV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCgQlb0fmkH9gwChNVd34mlPKflCemW/YnRgAng5Eb4=;
 b=Mhyz6hyOFfKcxbAdAZv+xSQ7RIWJs/WkI57G909tB78cglz8LopthUB1WBV5TzftXQszWkka+73IefEYaUqkzgAyEFyjayhyS4D+tDDCdUPthRY1gAA0uQ+g5aAuJyTeN925rRq9RyqRYlurpATrZWW6TZO78Ws8WZNxp9ORzW1tMBZgXVji5Meh4jfDJxZ4y/nTo2Szs++HlAOV7iIx1bWSOuipsFYVqFc198h5eudL2bQptnVTzE+ro02Fq0PD/dIhCaeDhx9CEdB72cyBtzMY1yB1uI48z3YvoWgG/Dt/11fT0+sXFTezZJCU9SpnRTtrmlnE0IRJmzC+5M+ozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCgQlb0fmkH9gwChNVd34mlPKflCemW/YnRgAng5Eb4=;
 b=V/jyjSWz1XzDfoL0xjYq3h0woHZqWRLWoc2bJBqvsjYCS0qty4ry3WiFHl8oGtFgnRm8tO1ZdS9omUSgfygc2VytZdGxEdKRhAayRWKlp61j/OiwwW9N5xIQWSyu7TWwbCTEiO/UBj2kRcfptG1yj6mVvju0iqdAH9sxE+uFYp/MwU3iGUePchwyOrGEVBfCflpoRZxAbLbXmHKlZTz6J9pmugEMs70edPAH0YXhrXqo7DCzH10tcxqpbpYCZNC8OUM0DEpgMoTNALGmiR32XeMnShVzhwk/hx0PfBPUjG1Gwry6Fy95x5UZL8fDhMPkslH7YJA9GzATlbO0uerldQ==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN0PR01MB6265.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.28; Thu, 27 Oct 2022 04:33:18 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::3dc1:f6bc:49e4:b294]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::3dc1:f6bc:49e4:b294%9]) with mapi id 15.20.5746.029; Thu, 27 Oct 2022
 04:33:18 +0000
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
Thread-Index: AQHY4/Chn/t4Wu6acU6x14mE2JkbVq4WOgwAgAr+4ACAAACzAIAAeOcA
Date:   Thu, 27 Oct 2022 04:33:18 +0000
Message-ID: <DE0BE36F-F02E-4FD2-9149-9CC2019BD85F@live.com>
References: <23DC077F-69DF-402C-A940-2E7EEABF2D97@live.com>
 <CAMj1kXG03-0AdM_ROf2UhH-N2Z52v7ox_emSQw=y5p3sMeTrMA@mail.gmail.com>
 <E48DD0F8-D9C5-4BD2-87A9-CFF0C22D0447@live.com>
 <CAMj1kXH+ZQNcGXk96ta6SmAkU_hTCnCgU_AH0UbeAbfZtr83CA@mail.gmail.com>
In-Reply-To: <CAMj1kXH+ZQNcGXk96ta6SmAkU_hTCnCgU_AH0UbeAbfZtr83CA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [c8kjGf2sNGlDS3t0ehhyDgTTEshQ5mRA]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN0PR01MB6265:EE_
x-ms-office365-filtering-correlation-id: 6f1c983d-7a5f-42c2-0b9d-08dab7d45f4b
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 84b9uggP9UabeyiHQLVPE13Rev/rIyHZUuf8Lh9aSCw5o0ECDfL5WLqmq4nUeNLW/jF9QYlh+/0uDg6of47mpyngh6MvUpNsv28VqbZ8QCRdIbucf8lSk94spjUv+OaIsHUKcpvoaWPCi/GSXUOwKBGC8A7l0FDyvO1gQoWJjqxP4I/a2Ss22ptp2Yhm7nYDiAHX40dcpMicSlSEyJDhWVhDNZI+0gbLD5ND1OWlhA7nEu6Is4GTQ6dPcgPgfYmnLXJFVY414Z4d4TDM1/QpNJvx+Ud9Lwpw4zXFY17vwoXxGa/Ggs3NSgAcBy1EY9fE0KVC7Sm+IyzikNOV0eQvEOnZbML1qHjObCcpvxwSUsdq6IuuEFHheO4/qdvk8VDITXoUViWqata6L9lddlJNoGXA99QleLO7btOcQVF9UNZZjmOgeJYvzsNDAIBrsPpsBEm4dQgM15EvOUh7ixIz99V7tZ8T9SK9c0b0BCwd//nKogYRZN50cqGBiL1MGGtKThzTwBjI2DoluAU9V2T8IYsb9lLMrAmmUM9FO3iveXf0lM/qeH4k9nG5wa0QYb+BT1VVfM9z9sga3e8KUGA9/BKyc9sT53OQdRDSi/6B8nVr/Xv5blUlKpGSugG4+RtleZ/twDBbQ9Ip1soXR0X3JO9f6kVGTquN+cfm7DMCIt7rIBGpjQ/Fw/dNpefcPlEe
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0VCUFpOMGkvL1lrei9NVUJvMzMxczdxWWl6d3BXOXBIemtMNSszOFd5V1ZB?=
 =?utf-8?B?R1ZZMFgxR1paQUd3bnR6bEw3VzU4SktIVU92UllrNHRiQTVJVDJLWUkwdnI0?=
 =?utf-8?B?M0JIbEw4ZTZMVklHRW9mUVJzRmJrQXFTcUtxYzNKeHQ0WWQrbU9BYXpXdlQz?=
 =?utf-8?B?WjN3cEdia0lnbmthNUhyRFBscStLV0lMUm1adm01Und3NDZlU0J3b1BxRTN3?=
 =?utf-8?B?OFVXK0lGeGR5REZUL2JNZWZRZ3kzSnF1MjBCSlFwWGVJVENWc3BGTWhpcUls?=
 =?utf-8?B?NlZ0R1RRc3dLUlZFS1dmTklnUjdJSkJ4eW1OY0hDcUhsSXhQaVUza09xc0Zv?=
 =?utf-8?B?WEtSQys3ZnVDTngrUERsT3hndzdYREhkc1JjUTNWYVVZRUdnUVhjaHRzakFq?=
 =?utf-8?B?RlhjcTVJSlhnRmMwTmpMY1R6d3J3WElwUDNIMW1JUnY1ZjdvVStxY1BFUkVm?=
 =?utf-8?B?VmpQYWVMUm9kclRIOWozdEpXcEJ0NTkrK21UTmpiSWZDRDg2OU5aUXdhNk4r?=
 =?utf-8?B?aEFaQ1hTeVhXS2tURDlwenQyakNES2ZtSlNkSmNzendjckZEbEdnSXRCK3VF?=
 =?utf-8?B?V0U0M2dKbTA3ZFBna3lqRkIwVGFMclI5Vi9weE1seXZoYjBsTEhzVExkMXZD?=
 =?utf-8?B?akd5QXR3SnJEZXJpOHphYkhESC9hQldmVU0vNUU0VWRNVHpLaHJ1SURUVWhR?=
 =?utf-8?B?bTJHY200QVlRUlBDYlYrZytHRnFrbWMxMCtSVVVscGxBK0p0MHNIQlhKWjJy?=
 =?utf-8?B?eUNSNk5CbmJ0eGpLZVlhNVdtcGpPWTgrMDE0SmpHK0JpK1AxcXF4K28zQ0VW?=
 =?utf-8?B?SXRQeS8wQ2RTS3NjMHdyWjMwdGdqeUlSbTVveXRXUGhQN1Zndk42WGdUeFAy?=
 =?utf-8?B?ZmdyUTBPWWYxclF6RXMyWHVZaVhKNXN1c25rSU5qUWtoNDNpd0tRL3lTY2Qy?=
 =?utf-8?B?VTF5QXVTVXJnZ1JBQXBEKzVhRjk1amJLWE9pWTlZcWZQdVdoZUFaS2tCUGJj?=
 =?utf-8?B?N3gzK0lLOEpXM1Rzb2tIVG9GZnh0cTd3SVRuTFB3eWhYYkZtSjY3bDQvR0hI?=
 =?utf-8?B?Zyt2TnFhc3hwOVptNWRPdXJqMnM2YzlsRnR2dGZUODE1YjJic3pyVTVFVlFI?=
 =?utf-8?B?OVkwS1E2TUtFN1NiYkRXcjFXNGx1WFk0ZFh0Q2N1VldpREl0bGF5aHpqRzMv?=
 =?utf-8?B?eHFQVXUwTlFscC8xcE9ON0Y5M2wreHBXUUlxbzlRbHJsU2pQcUZrRk9CMTVL?=
 =?utf-8?B?MXhPaTJqWjNtRDZvNSt4dFlEYXVrL1Zqd2pvZ3c5N29XQ1lpQTM3cVJWd09W?=
 =?utf-8?B?a2k2VGg4NVFFT0tuQW90NXZ1MkhjZjBBV0JmVjFZZXVIV2JyMk0yQW1CRmc1?=
 =?utf-8?B?Ym9XaHdLZUYxbXovbldGVWt3bGZWODlKNjNTS0F5Qms2R1Q3L1NUM0xFU29T?=
 =?utf-8?B?TEYyUVk1T3FhNGY3a294bUNvWWJyQzIxRGppOXZKcVY3emZvTllrSE84dU4x?=
 =?utf-8?B?TVF4cStSOUQvbjFTbW4rKy9DdVVyZWxDOTNFc21SZWpxam1manZWa014OVU3?=
 =?utf-8?B?TEcrZnR1dldmMmp3ZHBvTE9tR1dVcmlTaGFHWERRb245dzdySXFCdHpnZ2tT?=
 =?utf-8?B?WHpYOXBTdktKRXNKQmlzR01MVVU3cXBDeFkzdkxrRGs4a24vbHFwNEFjRVBO?=
 =?utf-8?B?eS94d3N2cS90K3RJelhqc2FDaHY3SkwwWjEwL0M4TU1hc3J1QTkvM2N3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29A038B0D93A7942A71D4FD0AEE0FB66@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1c983d-7a5f-42c2-0b9d-08dab7d45f4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 04:33:18.5737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6265
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGkgQXJkDQoNCj4gDQo+IFRoaXMgc2hvdWxkIGJlIGZpeGVkIG5vdyBpbiB2Ni4xLXJjMg0KDQpJ
IHRlc3RlZCA2LjEtcmMyIGJ1dCB0aGUgaXNzdWUgaXNu4oCZdCBmaXhlZCB5ZXQuDQoNCkkgZ3Vl
c3MgeW91IGhhZCBhcHBsaWVkIHRoZSBwYXRjaCBpbiB0aGUgbGluayBiZWxvdyB0byBmaXggdGhl
IGlzc3VlIHJpZ2h0Pw0KDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0L2RyaXZlcnMvZmlybXdhcmUvZWZpP2g9
djYuMS1yYzImaWQ9OGEyNTRkOTBhNzc1ODAyNDRlYzU3ZTgyYmNhN2ViNjU2NTZjYzE2Nw0KDQpI
ZXJlIGlzIHRoZSBidWlsZCBsb2cgb2YgdGhlIGtlcm5lbCBJIGNvbXBpbGVkLCBqdXN0IGluIGNh
c2UgeW91IG5lZWQgOi0NCg0KaHR0cHM6Ly9naXRodWIuY29tL3QybGludXgvVDItVWJ1bnR1LUtl
cm5lbC9hY3Rpb25zL3J1bnMvMzMxOTExMzE0NS9qb2JzLzU0ODM4NjMxODANCg0KQWx0aG91Z2gg
aWYgSSBhcHBseSB0aGUgcGF0Y2ggeW91IHNlbnQgbWUgb24gNi4xLXJjMiwgdGhlIGlzc3VlIGdl
dHMgZml4ZWQgYWdhaW4uDQoNCg0K

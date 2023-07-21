Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC5175BB68
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jul 2023 02:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjGUAC6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Jul 2023 20:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjGUACz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Jul 2023 20:02:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0760F171A;
        Thu, 20 Jul 2023 17:02:41 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KLMXYN006769;
        Fri, 21 Jul 2023 00:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HFCd094XvMsA0otC+QUzwAklkFjFADSbKfJmB4wvItQ=;
 b=MsCgpxpP3aNFyu6SmGee7sG/bJ03Ad0OxwGlMqDzhY7EeLAFb0/JiMdqDEv9jU9zsN+V
 11LKKSqnDTaZgPHBi1aNYSOHB6q+eSM9JDRm5k7BrAbk5WRqfsN37e1dT/De6Zjms1JX
 /ksdP/Vt+i6Kk9mgXw6Emt/9Ic5Ntn2Kv1hJy5kGCacGzv9f/KDABHnXxJRRvW+4rMUz
 BP/pTh+mqDMsQyYWiME1Q5FEHIyAs9woUHksuKQvHQ/bsOM6LsupdE6sSXNCTZ8fsF5V
 tjkjpd0kIcVMm1mjmCT6JkHAC+EnMP/cSyVxDsGqKHpZTl8RNd/iHmoyY+acrHyNOJDb bQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run78as3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jul 2023 00:02:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KLguHC038162;
        Fri, 21 Jul 2023 00:02:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw9awb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jul 2023 00:02:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCTC+Cw8hIX0PTit8oyG1ZZsjTw/RbBCbbEYuApYsoBz2Bowlg1BRdLe1OfpHg2BtE1Uod5WHu0AHXxstPOAmtgH7A8YPiCLSfy2l2vSUeKECwZCZ8AW6reCLd2a8kvXJDNbTtMrdqge5Mf1zFPoCRe0I8TrOJlzK36f8i/XFhSs0So0sa/oMEega6ZBLD/VXX7W3sFBZnmqSe9lvB/VbybqTDBYPpP0vGZsVyF47Rnfrl6pm3v4P59Fih8xIBqcH+pnrjEdwGy7WRj2W0o93uleoc1SEkW7NcR9hjUaWSLG8b12+cBHm7ILTl8pXWVyXJCkNkvEL1ehBeqRfZr5Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFCd094XvMsA0otC+QUzwAklkFjFADSbKfJmB4wvItQ=;
 b=fQLTVuTgaKJcRAwbyEWMj610npi1MigtjaIYHeWcZomsSdRO1bG4dG3bYfNFljS7QPG4EFvCy0G6acbkUYEOhQVG6lqWJy1+QXqapMVGBoOhCQQZCU0Sqeylx8YMnI37vJTG/YKSrzGdTbGlrywg3ldW9+/lfCrIyoXCZZUQZMv8OjLq29YOdV7Usl5reoH/fLIWO8vwYPilv6MAiHvSaMmUv81JmuIbYj+ahCL3PpHRyRaI7PvdO+dKFmSGBFp8XEn1O0H9l/MyIZgvRgzi3fyzGBZlhHaXYyDjLdFjuKTQmYsN8mMN1bFWwj/14xwC2EcZO+2J7VPbqII/PKanjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFCd094XvMsA0otC+QUzwAklkFjFADSbKfJmB4wvItQ=;
 b=bo4SNXzx2FuEFgwYQhL6GasTdjn0gU3/yd1FVb+YsEB3ZDF5S2pf0xH7VOzEn7tj6HSO6mheXzJvaK5RMFypgmfi+UVe6B0XrVFNZ4gbHoke2UQcoFIMQ/WAbsQbuRSNZGhK2gcsajLE8GhGEMyXHai+A0xeQFB5bxDWYQd29dY=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by PH8PR10MB6645.namprd10.prod.outlook.com (2603:10b6:510:223::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 00:02:02 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9beb:8c8f:3c09:a965]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9beb:8c8f:3c09:a965%5]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 00:02:01 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Luca Boccassi <bluca@debian.org>
CC:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "lennart@poettering.net" <lennart@poettering.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Thread-Topic: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Thread-Index: AQHZtZFPNdQ9vtMEUEOriR3uv4Pj06++JrMAgAANbACAAAVEgIAEruoAgAAp/4CAAE+0gA==
Date:   Fri, 21 Jul 2023 00:02:01 +0000
Message-ID: <635B383C-38A5-479E-80A6-358D5F90988B@oracle.com>
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <ZK/9MlTh435FP5Ji@gambale.home> <ZLABozIRVGmwuIBf@gambale.home>
 <ba2354dc63fd741d2d351b18d4312d0771c0935d.camel@HansenPartnership.com>
 <ZLVyvAXwtemx1I6p@redhat.com>
 <0aa647f719103e8620d7209cbde40f04a7334749.camel@HansenPartnership.com>
 <FBDC67DD-856F-429B-8E91-B0CA8B0F24B9@oracle.com>
 <CAMw=ZnQ5pjwJZdX9kyib=vFd_c5_5_eUhV_mT5OcRPt693m=Yg@mail.gmail.com>
In-Reply-To: <CAMw=ZnQ5pjwJZdX9kyib=vFd_c5_5_eUhV_mT5OcRPt693m=Yg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|PH8PR10MB6645:EE_
x-ms-office365-filtering-correlation-id: 2f2d12c0-e42f-4dc2-f8e0-08db897db597
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ErdKOf1qsEtx6lSSwzcv9J9Bn0Hq3iRXyAhkmUkWbgBffm/M2s+o8JtCixpf6yWhAn5NOlpwwI3H7IWbFJLbt/38sm8Y0KnN5dyliR2d3ct7Y2mKtaG3fX21zs9GxFs/BnnFAKtAiNgoLmoiazoHfOEnKiI7c8nyAwrqLzLoOytrOzR+AEG1ii3KwhJz+7g+SWoyrkbovJApyPe4m7ZDYDet08xgUC8oOmXe+XW+J4+WLVHBxyKtcUUF2LBMQIGOMkFoVUDu2MpK+pvIrD4nVRHqs7fv6mrE56ad/UwsajKey6hp9GWsZfmNMrGUG6ZolcKnGsi7tmDirTglEF2o9Dma7RB7yTzPpClgxi9AjNdFyD0A1ZxdC5EhbO0zNV6dy0HVH9Z82kMBAoLRk0IlBvZxXimdiAjEgLK6h/ZNVgJjMMNA9TuYhI0rMeLQXWp045SXBE18Yb4+iMZr+QzJAFAaYzKweCN86aQV1j7DJoJMKuCKvFeKurcFXWN2oOxcY2HbQtd3+tdPQDyANPx1ywogLsJdklj2bAdW3XVLaQ0Px7eNa/o0IvEhJ2LmRgGDGRAWZ25Qr2XBu/NlHve8Rbl2J3fTRIjHeQ+UPTOPHOsw5nO5iKX6Ai/CCpSBFz75Ammz3pbU9mJ+p32s1dZ5SSpm7kor41vcd5b7P/O+Am20is60Ew3ubkJ/wFaokyL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199021)(2906002)(41300700001)(316002)(44832011)(7416002)(5660300002)(38070700005)(8676002)(8936002)(33656002)(36756003)(86362001)(478600001)(71200400001)(122000001)(54906003)(2616005)(26005)(6506007)(53546011)(6486002)(38100700002)(186003)(6512007)(66446008)(66476007)(91956017)(64756008)(66556008)(4326008)(66946007)(6916009)(83380400001)(76116006)(142923001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzFJMWVaQnU2clVhQm0rSEIzUGVGYkQrTUtWSThoZG1rZll2STU0d0p1ckZi?=
 =?utf-8?B?WWJaTHA4WEVaN0dNUlpkWE8rOFBsUFVrVEhOd1hIaGdQRUpuUFR6WEQvSU5i?=
 =?utf-8?B?T2pwQ3l5UjMyd1NCa1dKeHFvMEw2TVVkVkNKeHRKQVYwQkNUMUQrSFlEa2JM?=
 =?utf-8?B?bnJaMkQyMjBxOFRCTnF4UTEvbVVaVHJmU2s0citjb2IycjlETFFnTG9yS1gv?=
 =?utf-8?B?OGF0aHlIQ2hRNWF6ZUhKLzY5UEtEa2RXSTV4N1BIc21lZUpYU0xTYXczTTN4?=
 =?utf-8?B?cHZmaGdHVGx5Nm1GZUZCTEo0b1dBbUFISWN1VEF1dFdEeUt5eTl4MUFucnpo?=
 =?utf-8?B?aWlZcmNTeFMyM1ZRQkhrbnV6c1R5RU0vUXhKclFkbGQ0dGo3am05K2NCdng1?=
 =?utf-8?B?UnlUaXZrL1lsdGdlQ25zYVhFekc4cWduZkRpc2k1aGhUU0Mvb3I3NkdsTHh0?=
 =?utf-8?B?ZEU4cU01c0JmN3htcWlxeUpsWUZEMzZsRUNnd1NjbUVtSE80TWNDUXlZcUFw?=
 =?utf-8?B?c202SDVrRmU5c1RnV1A2Vk1TdmY1UjNqQjRyUmdTSzIxY1FyTnlKSk55RlEx?=
 =?utf-8?B?MnNRL1IvRmJoTFF2cjJlbWorRW9OUVhFbTlpMERDL0JrZXBQTlg3Sm1GOXVh?=
 =?utf-8?B?YnZyTktENFN2bzE0V0FOdnREMFdkcXBsQW91ZllQTXplVUdmV3laVlBrenBv?=
 =?utf-8?B?SE9BQ2JDaUxReEd1QnhIY2tjclJkOVg0UmVCUEJMK3dSbU8zQ2tRTFZRWENx?=
 =?utf-8?B?NzA5U0ZmdzJLVDNmWHJCVkw5QlMvQ0p0WlBzaktxM2FmK29uMTNFTUtKdDdK?=
 =?utf-8?B?bEJSZ2xOY3NoRzBMV1libDNDYXE0TFBCQ09XTHY5bFd4eWY3MjI3UXF6QmJt?=
 =?utf-8?B?VnVRVDA5bTNyK2NiU2ZUbndPYmFzUklVNjBhcXVzbEMydXkxN3loWU90TVJi?=
 =?utf-8?B?TEdYVXV1VE9wZUxwUVVUR0pUTlMyQUEwcjNTNFZBemY3QjVGcHh1SDlSdUda?=
 =?utf-8?B?eE0vM0s1TjI1K1U1c2NsT3Vudzd1YXBwNythRDhJdmxiUjAvcW1mR3VvdzZE?=
 =?utf-8?B?STl1MzFwNnpJK2RscTI4SzVERFBOUk81S0pFUnJ1N2JldTFUMzdZSnZ6V0lG?=
 =?utf-8?B?eFRsZm5RZGRNMkphWVZoVjgrcytnUzc4K0ZBaDB3VUNQQ1B1Sm5GWHAzRXVB?=
 =?utf-8?B?UVI1alg5ejVKaFNLTUlKc3ZsK1J3N2ZuYzVELzVQdksrUndNYWpYK0Ezajla?=
 =?utf-8?B?UmE0RVhYcDFTZkZCTFBHSHJPY0lPSnorWGN4QWdPMHE3RzY1ZWdEZFRZMEZY?=
 =?utf-8?B?aHZZZjBZdjcvRnFQclB4bWIzeU4zbUJlQXdURFg1aHhLUktXNEVxWUJEc09V?=
 =?utf-8?B?Y2NROTlsWi9haitCeE1Kem50VlZ0NGxIVlhkOWdMclJJdnZaZittbGdPVnFK?=
 =?utf-8?B?amw4OTN3dm5NZ2MrbXl3aGhDOUpHek1jWVk0aU8yQkt3djFiWTFHUitRVStj?=
 =?utf-8?B?YVJDalp2L1p1bTlIRUkyOVFQY29JY2swMlptU0ZzeTVCWkJUNmw0ZDg4VWtm?=
 =?utf-8?B?dmcxd3RLdXRDMUhYWWZQQ2syai9rYTdCdWxvOHU2L3hCY3R6Z1pZSUtIeEZk?=
 =?utf-8?B?Q3ExRWhOSjlTem5pOGJpWEUzaEVXd0h4WlJxdXc1WEtSUmh6WWtJWTNQMllO?=
 =?utf-8?B?cU9rYUFKcFFKOS95Z09RMUp3ckFwVi9EanRiMHZ0aDB3RXlXbnlPekJuTitG?=
 =?utf-8?B?eGVnNC9SWjdMVFd4TUcyN1YrbjlwY3U1RE5xK29IUUc3ZE9EMW5pRE5hNDFv?=
 =?utf-8?B?UGE5NnJNNkpNN0FDMGxUZU5CVy9wMDVKbk8rd2pEVzlFUUpWalNYU0E3cnZW?=
 =?utf-8?B?MmNOakh1KzBZYi91TTFRZTFsalNFTUNnbkk0WHVJOFFDdFE5b3pZTGc3TkxJ?=
 =?utf-8?B?Wnc1VldsL1grODFPMWJOcnlZUG9jSU1aZHZXaFFaWkhicUxIL0U4bUN2MFZK?=
 =?utf-8?B?eFBKZWJ0a1lpMFhaS2ZLWDF4SmNpb2xGYm1LenUyMFJwNDVwbElUSW02QVgx?=
 =?utf-8?B?VUtORTl6ZGozQzE1dUk5dkszZFVRSUJiOEMyUXl3Vk9JeFhwMGRneTBjM2V1?=
 =?utf-8?B?NTdrakxDeTdock9TZGxYWE1oOEZ6Ym92VkRCS0N3REJDeStBbXh5OEord0pK?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F19C0EB482F0D34BB1E9393A9B073FD5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Qnd5L0l6akVSQlZ6WmtZaE9RMmxEbmtrZWxyaDdxY0g3Wi9zY3ZmVjQvZDM3?=
 =?utf-8?B?bUFwMVc4NmNNWUd6R1FIQXAxdXlxODNERVRibzc3UmtYNld3UjZWS2VkeHdo?=
 =?utf-8?B?d2VLUiszZjRXcEpJWG03cC9ucXFXQjBxS1UvNTBLb0k5VkhUdm9QZXFnZSt6?=
 =?utf-8?B?TU1saHV5SWNjQnVBOEVwSEpJVVk4dVk3aU9rOE9ZOS9EcmY2Q2lHTnQxcHho?=
 =?utf-8?B?ekRSdlBjbERtdHZGZFMwVUxPRWFRMlhNKzFmckYyeit6SVhVWlloT1h5QmVB?=
 =?utf-8?B?NFd4VTQrUGhZdHkyazRyaktzTU1ZZG82dmEwZEQ3L1g1VTlRZkQ2a2c0MkMw?=
 =?utf-8?B?bWxRYWVsWGgrWFUvM2llNHRRTU01Nm9NREhkZGZXWTZxODhCdmc3VHRqdTc3?=
 =?utf-8?B?VEJXNTRETEMvQ1A2TnpMTmVoYnlLVWpLbE9aVk1ITnlBYzZyWk01U1BzSUhs?=
 =?utf-8?B?WFNObFZaUkFIeDFVenZUVmlmSnMvQW1TQmUxdVZnZ3ZDcTBab2E4T1lhY3Ay?=
 =?utf-8?B?Ry9aMmtSSHFjQ210SkhiZWZiYzRFVmV6RGo1WE5JVnkrL1A3d01qQXhnb0NS?=
 =?utf-8?B?Z2VaVWZ1MWZVV1pQZWxXOEdLUkdUSXdWU25tS2xZQWhVTW14SGMzbFR3ZFcr?=
 =?utf-8?B?SXRMLy9HS1hMUEREM01wN0dzSDh4eFJGV0I5U2owVzNZd0p1MVRLTVdOc2NF?=
 =?utf-8?B?N0x1SjNrOW1iM1hEaEYzZmVIclpUb001ZVFsQnZQdC9mZzBQNnFQOHZGcnov?=
 =?utf-8?B?T2xnSUR5VXlHaTBTV1lPaXV0NXFGbGtESkVUR1V6cms1QzBFS0Z4Qmlvd0ZH?=
 =?utf-8?B?N1N4Q202YUVmV3o5RExWa1ppRnVFWGtmVlgwcEU5eVZET2FldmQwUU8rSFFu?=
 =?utf-8?B?d3RYVE4zRXJBc2ltQitSVTFKcW4rVWRPVDV2bktJUVlVMFFETW9mV1Rhd29L?=
 =?utf-8?B?WnN3aFJZUm5XT3FsNHFOM0lQbTlzSnIvQ0pQd3ViejNEMXRZSjdZNnlvcGNE?=
 =?utf-8?B?aGJRcEUrcGVDS25pZnBrVDYzWTJCNUJ1QjB6VkUvSERRZGxicTdhcHR6VWwz?=
 =?utf-8?B?dkNTRUFKS3dhdGVLRURUQ0xVbkw4bmFyelhqQTUrcVo5L1V4UDlyR01WbWpa?=
 =?utf-8?B?cHFRTjRoMVdWQkNTRkU0UUE2WVg4ZGMvcjRabFMwWUFndDducFpmcEE4NUJ0?=
 =?utf-8?B?M2Y1ZUNpTklTV3QvL0gyQ3craGFpNWt5QjZ4eXlreDdNNzJKemFiYUFEZis1?=
 =?utf-8?B?MHE3TG0yQmZpbFBEV25WSVBzZ0FkZFBpTFU1Y0lKay82M09oazZVTm5RWGlm?=
 =?utf-8?B?WldPai9BUlVHdmFHOUxyNkg0dTlSVVVsWDd3U2x5Z2JVMklmUGEwTU1jWGZ4?=
 =?utf-8?B?bERUSE1idTF3UnVYNk02Vy9sOEJXRW1tOTEwTEdOZmpwcW52NGRLVWhWb1Iv?=
 =?utf-8?B?UE1FWGxhZDZTNGRXVEI1NXFKVHl3NXI4TGNOS0hKa3RMZGlVTitnNlU1bGJz?=
 =?utf-8?B?SmRoOEpLTVg5QlFJUFR6V2JQTGlIWnVaK1NyakJTelFTM1NhUmNlUkZqMHJV?=
 =?utf-8?Q?22rShg+auSbRSLzr59v9xSdrk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2d12c0-e42f-4dc2-f8e0-08db897db597
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 00:02:01.3379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1gyXi4DQ0Mzatez9GBF96DY5G5Yz8Riayum/1tib3/gIi9pN+T8RLfVbLIvmb0Y/WwMXRoEchnxz0HNE53E/jF+IPgTCYq6I3mTFzv7b80Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_11,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200205
X-Proofpoint-ORIG-GUID: iHlHHDBbe5-tikSlSCPfNmJxXe2yDZo-
X-Proofpoint-GUID: iHlHHDBbe5-tikSlSCPfNmJxXe2yDZo-
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gT24gSnVsIDIwLCAyMDIzLCBhdCAxOjE2IFBNLCBMdWNhIEJvY2Nhc3NpIDxibHVjYUBk
ZWJpYW4ub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgMjAgSnVsIDIwMjMgYXQgMTg6MTEsIEVy
aWMgU25vd2JlcmcgPGVyaWMuc25vd2JlcmdAb3JhY2xlLmNvbT4gd3JvdGU6DQo+PiANCj4+IChh
ZGQga2V5cmluZ3NAIGNjKQ0KPj4gDQo+Pj4gT24gSnVsIDE3LCAyMDIzLCBhdCAxMToxNSBBTSwg
SmFtZXMgQm90dG9tbGV5IDxKYW1lcy5Cb3R0b21sZXlAaGFuc2VucGFydG5lcnNoaXAuY29tPiB3
cm90ZToNCj4+PiANCj4+PiBPbiBNb24sIDIwMjMtMDctMTcgYXQgMTc6NTYgKzAxMDAsIERhbmll
bCBQLiBCZXJyYW5nw6kgd3JvdGU6DQo+Pj4+IE9uIE1vbiwgSnVsIDE3LCAyMDIzIGF0IDEyOjA4
OjI2UE0gLTA0MDAsIEphbWVzIEJvdHRvbWxleSB3cm90ZToNCj4+Pj4+IE9uIFRodSwgMjAyMy0w
Ny0xMyBhdCAxNTo1MiArMDIwMCwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6DQo+Pj4+Pj4gKGFkZCBs
aW51eC1lZmlAIGNjKQ0KPj4+Pj4gDQo+Pj4+PiBUaGFua3MgZm9yIHRoYXQsIHNpbmNlIHRoaXMg
aXMgcmVhbGx5IEVGSSByZWxhdGVkIHJhdGhlciB0aGFuIHg4Ni4NCj4+Pj4gDQo+Pj4+IHNuaXAN
Cj4+Pj4gDQo+Pj4+PiBUaGUgcHJvYmxlbSwgYXMgSSBzZWUgaXQsIGlzIGlmIHRoZSBkaXN0cm9z
IGdpdmUgdGhlIGtlcm5lbCBhbg0KPj4+Pj4gLnNiYXQgc2VjdGlvbiwgdGhhdCBtZWFucyBhbnkg
dmFuaWxsYSBrZXJuZWwgdGhhdCdzIGJ1aWx0IGJ5IGEgdXNlcg0KPj4+Pj4gYW5kIHNpZ25lZCBi
eSB0aGVpciBrZXkgbm93IHdvbid0IHdvcmsgKGV2ZW4gaWYgdGhlaXIga2V5IGlzIGluDQo+Pj4+
PiBNb0spIGJlY2F1c2UgaXQgd29uJ3QgaGF2ZSBhbiBzYmF0IHNlY3Rpb24gLi4uIGFuZCB0aGUg
c2JhdA0KPj4+Pj4gbWVjaGFuaXNtIGlzIGNvbXBvbmVudCBzcGVjaWZpYywgbm90IGtleSBzcGVj
aWZpYywgc28gdGhlIHNpZ25lcg0KPj4+Pj4gaGFzIG5vIGNob2ljZSBidXQgdG8gYWRvcHQgaXQu
DQo+Pj4+IA0KPj4+PiBBRkFJQ1QsIHRoYXQgcHJvYmxlbSBvbmx5IGV4aXN0cyBmb3IgYmluYXJp
ZXMgZGlyZWN0bHkgaW52b2tlZA0KPj4+PiBmcm9tIHNoaW0uIFNvIHRoYXQgd291bGQgYmUgYSBw
cm9ibGVtIGZvciB0aGUgYm9vdCBsb2FkZXIgKGdydWIpLA0KPj4+PiBvciBhIGtlcm5lbCBpbWFn
ZSBiZWluZyBib290ZWQgZGlyZWN0bHkgd2l0aG91dCBhIGJvb3Rsb2FkZXINCj4+Pj4gcHJlc2Vu
dC4NCj4+PiANCj4+PiBXZWxsLCBjdXJyZW50bHksIHllczsgdGhhdCdzIHRoZSBpbl9wcm90b2Nv
bCBjaGVjayBpbg0KPj4+IHNoaW0uYzp2ZXJpZnlfc2JhdF9zZWN0aW9uKCkuICBIb3dldmVyLCBJ
IHdhcyBhc3N1bWluZyBiYXNlZCBvbiB0aGlzDQo+Pj4gdGhyZWFkLCB0aGF0IHRoYXQgd2FzIGJl
aW5nIHRpZ2h0ZW5lZCB1cCAoZWl0aGVyIGJlY2F1c2UgcGVvcGxlIGFyZQ0KPj4+IG1vdmluZyBh
d2F5IGZyb20gZ3J1YiBvciBiZWNhdXNlIHRoZSBzaGltIHZlcmlmaWVyIHByb3RvY29sIHdvdWxk
DQo+Pj4gZW5mb3JjZSBpdCkgYXMgeW91IGltcGx5IGJlbG93Lg0KPj4+IA0KPj4+PiBGb3Iga2Vy
bmVsIGJpbmFyaWVzIGludm9rZWQgaW5kaXJlY3RseSBieSB0aGUgYm9vdCBsb2FkZXIsIHRoZQ0K
Pj4+PiB1c2Ugb2YgU0JBVCBpcyBjdXJyZW50bHkgb3B0aW9uYWwuIGllIG1pc3NpbmcgU0JBVCBy
ZWNvcmQgd291bGQNCj4+Pj4gYmUgdHJlYXRlZCBhcyBzdWNjZXNzLg0KPj4+PiANCj4+Pj4gVGhp
cyB3YXMgYSBwcmFnbWF0aWMgd2F5IHRvIGludHJvZHVjZSBTQkFUIHN1cHBvcnQgYXMgaXQgb25s
eQ0KPj4+PiBpbXBhY3RlZCBncnViIGF0IHRoYXQgdGltZS4NCj4+Pj4gDQo+Pj4+IE9uY2UgYSBk
aXN0cm8gc3RhcnRzIGFkZGluZyBTQkFUIHRvIHRoZWlyIGtlbnJlbHMgdG9vIHRob3VnaCwgd2UN
Cj4+Pj4gY2FuIGZvcnNlZSB0aGF0IHRoZXkgd291bGQgbGlrZSB0byBlbmZvcmNlIFNCQVQgZm9y
IHRoZSB3aG9sZQ0KPj4+PiBib290IGNoYWluLCB0byBwcmV2ZW50IHJvbGxiYWNrIHRvIHByZXZp
b3VzbHkgc2lnbmVkIGJpbmFyaWVzDQo+Pj4+IHRoYXQgbGFja2VkIFNCQVQgaW5mby4NCj4+Pj4g
DQo+Pj4+IFRoaXMgcG9saWN5IGNvdWxkIGJlIGVuZm9yY2VkIHBlciBrZXkgdGhvdWdoLiBlZyBy
ZXF1aXJlIFNCQVQNCj4+Pj4gZm9yIGFueXRoaW5nIHZlcmlmaWVkIGFnYWluc3QgdGhlIHZlbmRv
ciBrZXkgdGhhdCdzIGNvbXBpbGVkIGludG8NCj4+Pj4gc2hpbSwgYnV0IG5vdCByZXF1aXJlIFNC
QVQgZm9yIGJpbmFyaWVzIHZlcmlmaWVkIHdpdGggdGhlIE1vSw0KPj4+PiBlbnRyaWVzLg0KPj4+
IA0KPj4+IFRoYXQgbWlnaHQgd29yaywgYnV0IGl0J3Mgbm90IGN1cnJlbnRseSBpbiB0aGUgc2hp
bSBjb2RlIGJhc2UuICBJdCBhbHNvDQo+Pj4gd291bGRuJ3Qgd29yayBmb3IgU1VTRSBJIHN1c3Bl
Y3Q6IHRoZXkgYWN0dWFsbHkgcHV0IGFsbCBvZiB0aGVpciBkaXN0cm8NCj4+PiBrZXlzIGludG8g
TW9rTGlzdCAoc28gdGhlIG1hY2hpbmUgb3duZXIgaGFzIHRvIGFwcHJvdmUgYW55IFNVU0Uga2V5
DQo+Pj4gdXBkYXRlKSwgc28gaG93IGNhbiBzaGltIHRlbGwgdGhlIGRpZmZlcmVuY2UgYmV0d2Vl
biBteSBrZXkgYW5kIHRoZWlyDQo+Pj4ga2V5Pw0KPj4+IA0KPj4+PiBUaGUgdXNlciBzcGVjaWZp
YyBNb0sgZW50cmllcyBkb24ndCBoYXZlIHN1Y2ggYSBjb21wZWxsaW5nIHVzZQ0KPj4+PiBjYXNl
IGZvciBTQkFULCBzaW5jZSBpZiB0aGV5IG5lZWQgdG8gcmV2b2tlIG9sZCBiaW5hcmllcywgdGhl
DQo+Pj4+IGVuZCB1c2VycyBhbHdheXMgaGF2ZSB0aGUgZWFzeSBmYWxsYmFjayBvcHRpb24gb2Yg
anVzdCByb3RhdGluZw0KPj4+PiB0aGVpciBzaWduaW5nIGtleXMgYW5kIHN3aXRjaGluZyBvdXQg
dGhlIGVucm9sbGVkIGtleSBpbiBNb0suDQo+Pj4+IA0KPj4+PiBUaGUgY2hvaWNlIG9mIHdoZXRo
ZXIgdG8gbWFuZGF0ZSBTQkFUIGZvciBiaW5hcmllcyBzaWduZWQgd2l0aA0KPj4+PiBhIE1vSyBl
bnRyeSwgY291bGQgYmUgc2V0IGJ5IHRoZSBlbmQgdXNlciB0aGVtc2VsdmVzIGF0IHRoZSB0aW1l
DQo+Pj4+IHRoZWlyIGVucm9sbCB0aGVpciBzaWduaW5nIGNlcnQgaW4gdGhlIE1vSyBEQi4NCj4+
PiANCj4+PiBXZWxsLCBJIGFncmVlIHdpdGggdGhpcywgc2luY2UgaXQgd2FzIG15IG9yaWdpbmFs
IHBvaW50LiAgSG93ZXZlciwgYQ0KPj4+IGtleSBvYnNlcnZhdGlvbiBzdGlsbCBzZWVtcyB0byBi
ZSB0aGF0IG5vbmUgb2YgdGhpcyBleGNlcHRpb24gcHJvcG9zYWwNCj4+PiBpcyBhY3R1YWxseSBj
b2RlZCBhbnl3aGVyZSwgc28gaWYgc2hpbSBkb2VzIHRpZ2h0ZW4gdXAgc2JhdA0KPj4+IHZlcmlm
aWNhdGlvbiwgZXZlcnlvbmUgY3VycmVudGx5IGdldHMgY2F1Z2h0IGJ5IGl0IChhbmQgaWYgaXQg
ZG9lc24ndA0KPj4+IHRoZW4gdGhlIGtlcm5lbCBkb2Vzbid0IG5lZWQgYW4gc2JhdCBzZWN0aW9u
KS4NCj4+PiANCj4+PiBJIHJlYWxseSB0aGluayBpZiB0aGlzIGV4Y2VwdGlvbiBwcm9wb3NhbCBp
cyB3aGF0IGV2ZXJ5b25lIGlzIHBsYW5uaW5nLA0KPj4+IHRoZW4geW91IGNhbiBzaW1wbHkgbGVh
dmUgdGhlIHVwc3RyZWFtIGtlcm5lbCBhbG9uZSwgc2luY2UgaXQgd29uJ3QNCj4+PiByZXF1aXJl
IHNiYXQgaW5mb3JtYXRpb24gdW5sZXNzIGluY29ycG9yYXRlZCBpbnRvIGEgZGlzdHJvLg0KPj4+
IA0KPj4+IFNvIHRoZSBkaXJlY3Rpb24gZm9yd2FyZCBzZWVtcyB0byBiZSB0byBnZXQgdGhpcyBl
eGNlcHRpb24gcHJvcG9zYWwNCj4+PiBjb2RlZCB1cCBhbmQgYWdyZWVkIGFuZCB0aGVuIHdlIGNh
biBkZWNpZGUgYmFzZWQgb24gdGhhdCB3aGV0aGVyIHRoZQ0KPj4+IHVwc3RyZWFtIGtlcm5lbCBu
ZWVkcyB0byBjYXJlLg0KPj4gDQo+PiBJIGFncmVlIHdpdGggSmFtZXMgaW4gdGhlIHByZXZpb3Vz
IHRocmVhZDsgIGFkZGluZyB0aGUgU0JBVCBzZWN0aW9uIHRvDQo+PiB0aGUga2VybmVsIHNob3Vs
ZCBiZSBoYW5kbGVkIGJ5IHRoZSBzaWduaW5nIHRvb2xzLiBJdCByZWFsbHkgZG9lc24ndCBuZWVk
IHRvDQo+PiBiZSBpbmNsdWRlZCBpbiB0aGUgbWFpbmxpbmUga2VybmVsIGNvZGUuIEkgYWxzbyBh
Z3JlZSB3aXRoIHRoZSBzZW50aW1lbnQgdGhhdA0KPj4gbWFpbmxpbmUgYW5kIHRoZSBzdGFibGUg
YnJhbmNoZXMgc2hvdWxkIG5vdCBoYXZlIFNCQVQgdmVyc2lvbnMgYXR0YWNoZWQNCj4+IHRvIHRo
ZW0uIFRoZXNlIGFyZSB0aGluZ3MgZGlzdHJvcyBzaG91bGQgYmUgcmVzcG9uc2libGUgZm9yIGlu
Y2x1ZGluZyBpbiB0aGVpcg0KPj4ga2VybmVsIGlmIHRoZXkgd2FudCB0byBoYXZlIFNCQVQgc3Vw
cG9ydC4NCj4gDQo+IFdoeSB3b3VsZCAnc2lnbmluZyB0b29scycgaGFuZGxlIHRoYXQ/IEl0J3Mg
anVzdCBhIHRleHQtYmFzZWQgUEUNCj4gc2VjdGlvbiwgaXQgZG9lc24ndCByZXF1aXJlIGFjY2Vz
cyB0byBwcml2YXRlIGtleSBtYXRlcmlhbHMgdG8gYmUNCj4gaGFuZGxlZCwgbm9yIGl0IGhhcyBh
bnkgcmVsYXRpb25zaGlwIHdpdGggc2lnbmluZy4gDQoNClRoZXJlIGlzIGEgcmVsYXRpb25zaGlw
LCB0aGUgc2JhdCBpbmZvcm1hdGlvbiB3aXRoaW4gdGhlIHNpZ25lZCBmaWxlIA0KY2FuIGJlIHVz
ZWQgZm9yIHJldm9jYXRpb24gaW4gbGlldSBvZiByZXZva2luZyB0aGUgaGFzaCBvciBzaWduaW5n
IA0KY2VydGlmaWNhdGUgYXQgYSBsYXRlciB0aW1lLg0KDQo+IEFuZCBhZ2FpbiwgdGhlIHBvaW50
IGlzIHRoYXQgaXQncyBub3Qgc29tZXRoaW5nIHlvdSBtaWdodCBvcg0KPiBtaWdodCBub3Qgd2Fu
dCB0byBoYXZlIC0gaWYgeW91IGFyZSBnZXR0aW5nIHlvdXIgU2hpbSBzaWduZWQgYnkgdGhlDQo+
IDNyZCBwYXJ0eSBDQSwgeW91IG5lZWQgaXQsIGZ1bGwgc3RvcCwgZW5kIG9mIHN0b3J5LiBXaXRo
b3V0IGl0LCB5b3UNCj4gZG9uJ3QgYm9vdC4gU28gaXQgbmVlZHMgdG8gYmUgZWFzeSB0byBmaW5k
IGFuZCBjb25zdW1lIGZvciBhbGwgdGhlDQo+IGRpc3RyaWJ1dGlvbnMvZ3JvdXBzL3Byb2plY3Rz
IHRoYXQgcGFydGljaXBhdGUgaW4gdGhlIFNoaW0gKyAzcmQgcGFydHkNCj4gQ0Egd29ya2Zsb3cs
IHRoYXQncyB0aGUgbWFpbiBnb2FsLiBNaXN0YWtlcyBhcmUgZ29pbmcgdG8gYmUgZXhwZW5zaXZl
Lg0KDQpJIHRob3VnaHQgdGhpcyBkaXNjdXNzaW9uIHdhcyBhcm91bmQgYWRkaW5nIGEgc2JhdCBz
ZWN0aW9uIHRvIGEgc2lnbmVkDQprZXJuZWwuIFdoZW4gc2lnbmluZyBhIGtlcm5lbCwgdGhlcmUg
bXVzdCBiZSBzb21lIHR5cGUgb2YgYXNzdXJhbmNlIA0KZG9uZSBpbW1lZGlhdGVseSBwcmlvciB0
byBjb2RlIHNpZ25pbmcuICBDdXJyZW50bHkgZm9sbG93aW5nIHRoZSBhc3N1cmFuY2UgDQpzdGVw
IHRoZSBhcHByb3ByaWF0ZSBwdWJsaWMgYW5kIHByaXZhdGUga2V5cyBhcmUgc3VwcGxpZWQgdG8g
ZWl0aGVyIHBlc2lnbiANCm9yIHNic2lnbi4gIElmIHRoZSBzaWduaW5nIHRvb2xzIHdlcmUgbW9k
aWZpZWQgIHRvIG9wdGlvbmFsbHkgYWNjZXB0IHNiYXQgDQppbmZvcm1hdGlvbiB0aHJvdWdoIGEg
bmV3IGNvbW1hbmQgbGluZSBhcmcsIHRoZSBuZXcgc2VjdGlvbiBjb3VsZCBiZSANCmFkZGVkIGlt
bWVkaWF0ZWx5IGJlZm9yZSBzaWduaW5nLiAgDQoNClVubGlrZSBzaGltLCBldmVyeSBrZXJuZWwg
d2lsbCBiZSBkaWZmZXJlbnQgYW5kIGhhdmUgZGlmZmVyZW50IHZ1bG5lcmFiaWxpdGllcyANCnRo
YXQgaW5kaXZpZHVhbHMgb3IgZGlzdHJvcyBtYXkgd2FudCB0byBwcm90ZWN0IGFnYWluc3QuDQoN
Cg==

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FB975B4EF
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jul 2023 18:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjGTQrW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Jul 2023 12:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGTQrV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Jul 2023 12:47:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293C4123;
        Thu, 20 Jul 2023 09:47:19 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KFF00d023562;
        Thu, 20 Jul 2023 16:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=P/CXpOJCJck1wbVCXTphWHUUziYZ0PbOxx1aTx9qqjU=;
 b=dYhRu7oaFzMTC5H7Gke8xI16tRPDFi3ZQaentPswMmpPlUoGpNRZvx5RYz9umi11bLWY
 fHRIQSfzItr8YOahTgkj5v8peQsHAr2m5fq9FwoCCe2YyNkt/BUE4ykrgmnp1vZIdd6u
 HD6Ex4aosN9h7wpe4IdhPa03/QN/v3YdidwwbE2GItzm5Y6Q0G2KsOPBNrsesNL+6S7j
 r29iisemqoNVsovYa1Cwk+XUidAZ4B0RjRBcBAsmmk+M6cJAHI+JhmTx5mJ5hXCssqfk
 oxZrue96YtRCLHpYt1A1ZCj1lv7B2yP0m36Nrz/hL10f2Ug30VPcnBZIyPvZ99UFkMae eA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run7728yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 16:46:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KFPsVn019207;
        Thu, 20 Jul 2023 16:46:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw9d6au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 16:46:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5FljLBaWd5UDTt23LNinO45/nIsRlVsrSY6bkQwzvgqHle4YUhsILw/aLacFY383R7hHBIRtlO4D09Y/Rc/iS/1TYB01FpOkm+2x2/a5MR09txOyVKtlA8kALqMqExlzX9FzgNbDyrPm+8NeMrxDFOAAG1sEyU8THJvCytt1/ybxGB5xdcYvWMdDWc9or8MIIeeuKhse+JWLwMnaVmYnpNzBO8MJAEHTkGjYTXAo1abV+DxbYk12GSSvPq/0dpfXp9ub1VeCTouDJiLekKHLC1C5HLG+rrYNdddnqy9y+Hcux0BgDOhNeVCSY/4LnuEZaJIRywK3wLUFKMnGRzcKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/CXpOJCJck1wbVCXTphWHUUziYZ0PbOxx1aTx9qqjU=;
 b=AuW+FpAiiu8d3xpJBvQA1354NGxdB9prie2SXzZ2z+9/I5r2JWZe9fHApnJY2ljnQe2ngLoXs71e1ce6on9fOwUkX6wpwObZ0prEZ5Ulbr7/MRiozIw0GtB1RUr4fiSYKdd17qsbTLJgKlD5qm4dxYKjiZjipEDnr1YtmDSeBRFd81mpbUF4umapZtT3pz3gScBBdngRGKFKszpVyCm/e14H0khSGOamAmhgacmO5mBZgtfib2+zsdZKjgTQazAgybv3OOpAOMnPzYVZXpaCCH7iSsGDEIJhHPWBfqL0r+I9a6EyFQhiFoXwYBETUag524/PbZt1Vo08eEFH7XfbVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/CXpOJCJck1wbVCXTphWHUUziYZ0PbOxx1aTx9qqjU=;
 b=b6lYg+MkFM4r4e1tbLYw7Rx2ximcR2gTDHJ5a2HfoIPfJdbFSXohcTghVGp2Ae4zUQqgGeKWGw2lcBADCXFF8DEUSCn18TrGOAszoR8c+pbD+bPiK5BuDIUt8Bmb7h6J6DsRZHWxio81Q//7asiunrXjr5H8Aiyo6diFoZg7f8s=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DM4PR10MB7426.namprd10.prod.outlook.com (2603:10b6:8:183::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 20 Jul
 2023 16:46:25 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9beb:8c8f:3c09:a965]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9beb:8c8f:3c09:a965%5]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 16:46:25 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "bluca@debian.org" <bluca@debian.org>,
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
Thread-Index: AQHZtZFPNdQ9vtMEUEOriR3uv4Pj06++JrMAgAANbACAAAVEgIAEruoA
Date:   Thu, 20 Jul 2023 16:46:25 +0000
Message-ID: <FBDC67DD-856F-429B-8E91-B0CA8B0F24B9@oracle.com>
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <ZK/9MlTh435FP5Ji@gambale.home> <ZLABozIRVGmwuIBf@gambale.home>
 <ba2354dc63fd741d2d351b18d4312d0771c0935d.camel@HansenPartnership.com>
 <ZLVyvAXwtemx1I6p@redhat.com>
 <0aa647f719103e8620d7209cbde40f04a7334749.camel@HansenPartnership.com>
In-Reply-To: <0aa647f719103e8620d7209cbde40f04a7334749.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|DM4PR10MB7426:EE_
x-ms-office365-filtering-correlation-id: 2f762c2e-9c96-4302-34b3-08db8940db5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CUFsgBSSHnxISFuS/sKGeyp+qYLlf6oOJtpQ3Y1aFosVgFeLuUf4c2kpIPnRuDfthciPjoH7mkMDeVaq0u339LPAxykx5MDGPERzYXWog6gwIi+CG57FmzPahWPWpVC7lAjpcdyNvKfI3Ykq45dEQSYD7E0mSDLrKgfUKM0QF7jwn4vUaDfOxzoe6xX1+uHg1gMl6pHgLX7NbVdRTPE/vshiz908fGWd7pTxjjQx5GscoOrgr1WxMBi62kPSFi0SVI7BkvVQQuOtJDQaI6iYWYw939pHULYgfaZproFn/oB2RWbCEKlJjcdYz9GXJwskdYOUrMNW5fpBsdlGQZ7LXv4CPuOpSOMdtCIjd/8e0jybmQrIccpttoIIHGJqOeB90KJKFFQaM5nFNiHUxVWcrm3nBQPN22CIWnjhTyHcxq9rPDwlcPtOT2hObaO5c+9zQwwuG1lF/IAmcK8Nx/1aaRVCe8wzMmI/O+bB3cKj7f/SYHMr0z7b++zOL3VMoF5BsWmX8zAPjACsCHq/DcK/WpELnVuJlzYH1s4qmfQoHC1Wq6OREn0ulaY3b37JL6vgv57Z8F924sHebTJzARc7GHE4Q9MjAx8HYhAAS/wbTbiCMIjse+pSByEDT/KTT+wKUlUhr0a+xyrKrIf2HQniXamz++uT4EgL0dy1P5SsdL0pcMDG1CPjHfyhFv3IYo2w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199021)(71200400001)(478600001)(2906002)(122000001)(186003)(6512007)(86362001)(83380400001)(26005)(38070700005)(6506007)(2616005)(33656002)(38100700002)(53546011)(5660300002)(7416002)(54906003)(66556008)(44832011)(36756003)(8676002)(6486002)(110136005)(66476007)(64756008)(66946007)(76116006)(66446008)(8936002)(316002)(4326008)(91956017)(41300700001)(142923001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUtlcWNtMkpPOHBqcU1qMGJVczdvTHlhWTliK3FqSHVWQk03QVJSQlFYTk8z?=
 =?utf-8?B?VDVJMUZlWnl1UC9WUTR2TFRHbjNROXJJY1VWQmIwdXUrNUpQZ3pxS2d0WXNr?=
 =?utf-8?B?QkFvaVA1NklDazNxM0dQQUpBeVVRZFIwTVhTTmJKekZXNE11UlhuRWhNOHh4?=
 =?utf-8?B?NGhOSmUvWk81TnZhVGFYbVM4OWZXN3JUNTFGMjVBTmQrcXhXTVBlTzFGV0JU?=
 =?utf-8?B?bzZzUVFGREE3VHh1YWRSSWdFb1FVN3krSzVQZ0E2cW5ER2paTS9GdEFrbDAz?=
 =?utf-8?B?M3pEQTZIU2dOUTRqTzNuYmUvcnZjcEJrVllscXQ1NklVeVNpNSs3dUlOcXIw?=
 =?utf-8?B?a3JLR3d3VkZYTXNOZnpmV0E4MjRveUMyUFdVQXRMeXVUVnZZWDZOZDBRM2VZ?=
 =?utf-8?B?Zk1TbHN4dTNRclgxdllPUWVwcXI0b2JpZGthL3pLaEFqMW9BeXFUdFdxY2JU?=
 =?utf-8?B?YVRrUFY0QVUvZVRZSTVnWGxBaGV3eDBia3F3Lzg3aTJROW8rSEdhc1ZUVzUx?=
 =?utf-8?B?MVBrdkIrQjFQVjhMM0VtaUJtQS80RUJoNkcrRTJxQ1NRZDllUHFiUmNORG5h?=
 =?utf-8?B?aThsTU9oQzgvWjRPUkhJb3IxcCtqWngweWFHTWNxMVJMUFBDS0h6ZGtMT0VF?=
 =?utf-8?B?Y0FGc3N5VTZwNVhwYmZSTDB4THFtcjRQMFBFQTk4YlI4b0hicjVWTTFPVkxZ?=
 =?utf-8?B?ZTBLdUxEdWszcGl2VVpDbnJJa0tacklDc1BhRmlQbGE4b3ZuTU4xaENFMDVs?=
 =?utf-8?B?cEsvK0wvTXp4Tk5VZ3NsV3pDNEVoc2JJM3J4SDIrN25Ram00UUVwUEF3MTRQ?=
 =?utf-8?B?cnNVemsvRHFQTGQvcTk0WjlKdVdDNG90THkwM2Rud0ltS0RGN29NMy9XRy80?=
 =?utf-8?B?VjZUMVNJWklTY2MwMm52TXdqM1kvdTgxWE9CMnQrOHA4M1ZhSDA1Z1J0b2Iv?=
 =?utf-8?B?ekVMaUJOZlhPWmhrdndzT2dSUG0wSkhzSWhoYUxhenZTRmk3SkExMVUzR2Mx?=
 =?utf-8?B?QkR0aWJzRkJKeW5FallsZDROS044UVFHaTFkZVZNZEcxWmFyYVRvbWRXcmJx?=
 =?utf-8?B?bmdRS01yWlpDTDR3dk5KS3pSVHJwNTJuRlI3NDA0cmUvV2pYK29TM1pKcy8x?=
 =?utf-8?B?b2xsd2pwMmZsdXkrbFVlcXdESTdyRnJGVkRvNmRXcEduZ0EzYldNbElaM3A2?=
 =?utf-8?B?TllBcUp4OHM1TnJNTEp2VGRIeXdKT25lcy9ndHBYV2JwZEZvVG0wZUoyRVY4?=
 =?utf-8?B?R25yS2kvenJtZ2hrWDdXOEhRRSs1MWdNaVMvcmtrWXU2QUhGSHpOc05PMENE?=
 =?utf-8?B?MTlRRU1IOTd5STA3UHJFZ1lKeXN4Lzl2OXhISUZ6R1I2YXI1WDlmbHpPRlRD?=
 =?utf-8?B?alR2MmFWaEZVaHQ0SGV3RmtJU0ZJOE5iamxyd0EvMVlFdHlxMEdCMDRIemNh?=
 =?utf-8?B?b1FDei9PMmJkSGk4a2V1Tkh4dm9TQjRROE5nVzdoM2lsdEdDcEw1NUNOdktL?=
 =?utf-8?B?ZWdROUZFT09Td0E3Z0lpMWxucSthaXdBZWdFNU9nK0dKclFlVEQzZEhyeXRU?=
 =?utf-8?B?eDhGYlpUVVNRbVZFVm1IZmROVWw4WVJ0R09XZDlRSEhmU3FsWnNvWWpOTVEv?=
 =?utf-8?B?V3c5K0dJVEd3SWxKMzc1MDUvcUtPT2NZTTdIZzdpaTQ3ejgrbitjKzhOK3c0?=
 =?utf-8?B?YmxPREhTeUpZMUVTdEZnVC9iVUlMc2ZOMDNOcGNwWjJFc2xnVVpNRENxWUlH?=
 =?utf-8?B?UzZ2Z3NyNnJ6UmQrMVFCRHprKzZwT1plMGFjMnR2dmQ5N0pMVUkxRWxnY2Iv?=
 =?utf-8?B?ODZIKzREMzJqZ2xyVHpKSmNkbUFiL2FQN2tRMnNuaVVWcyt5Mkd4NVROVFps?=
 =?utf-8?B?RGp5ZHlUM29JQTVVUXlRWEZlUjJOMDVGNHp5MXg0NkVPVXJuUjM5MUVZYnE2?=
 =?utf-8?B?YnJZdVNuUDU2Qis5WmkyK1gwUEc0dDhSUzNTY2ppc0RTcGJHK1duTkEra3ph?=
 =?utf-8?B?d25oYzBTSGhRdkdSdGY4TlpYT1FOL0gvMnB5UWcyTXZhNkZRMzJHRVZhaE1W?=
 =?utf-8?B?dWJ1aC9acERhZDdSRytmd25xdlRUY2JjU0ZtNHIxTFFzYzVGS2JpcTRJaWJU?=
 =?utf-8?B?ekczb08xMjgwM214UU1BMmZoZGwzTzY1Y3B5SnJBejlLdzV0Z0FtbmFiOTU5?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D8CE1E2A8A77B4BA683342EAF8671F7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VXRNR3VkNUN5QzY5VVZwcVFId2FxYlk3OUNHTURZMEFSRi82UXFZL3hpaXAw?=
 =?utf-8?B?QkttL3ZQeTc3eHJ0VkJFZERJKzZITkd3NFhMMjhOdDVYNUlBZWxYejRNVnds?=
 =?utf-8?B?RTZSK0orUmwrTC9xWkV1dE9hOFowSTh2ckMwdDhmcTRSRXM1TlUxeGF6Mzgx?=
 =?utf-8?B?anJ5aURGVmNGaHVRUGI4OGNxUGd2L3Bza0UxVDdrbEpzay9vUTVBWGJ5Snh1?=
 =?utf-8?B?QzlCcVRINDJEUit1YXVBYTVOSG54VVNnVmJ3S0krSGh0Wk1UbGdDWExiclFP?=
 =?utf-8?B?STRHM3h6RjFKSFRNbFU4TzZpUmppNDZKOURzQ2VIRW5mMGZWaHI4M0FNVi96?=
 =?utf-8?B?V1VBU09FZ3ZXcUV4TEJ2RU1wbCtGQ050NDRvdVZPUkxnMUhkdXpzMzU1S3Ra?=
 =?utf-8?B?bDVEenZ1K0JuMDlqRU1tOXhWRGRUY3d5OElacHBTYmIvYm5JRzJweitqZ050?=
 =?utf-8?B?VzlwT0NIZHIxbmlJVjVacXhYdDZvTmdmMmlEZStqS0MwbEpzZ2Y4NHo1ZTZG?=
 =?utf-8?B?Tm1pQ251SDZLcHJ5K2lYRG42SUFXc1JnYzZ6c05obTkvS05NSy9WQUhpT2xY?=
 =?utf-8?B?ZkpqeFFzb3paRmVISkF2dE9pczNKZFBKUy84WERNNFBDTEJOaHJrRVRDZFht?=
 =?utf-8?B?YXhCVUxWZS9ZNGZlL2V0VnNLd3ZsN2RQSHNWQ2FhUlhCcUJmYmxKQjhmMFhz?=
 =?utf-8?B?MDlIejUvMDRwS0w5TFpxbEpSb0lReVExVjlEb210RUhNV095NzdjdzZ2dmhO?=
 =?utf-8?B?V3NFbGp0bER1REdlZlh6ZXVyN2FtQmppWmR3aW5zOUs1cnZ4WjMxR09mVUMw?=
 =?utf-8?B?d2tmNWhVUm1zdjhGZ04vUm5wWXMzNFZvOUFsQkZSY0dQUWxGeHpqTkhkczMz?=
 =?utf-8?B?MGtsMk54UDgwaFNObWUwWHpIbWwzNmREcW1vRHBvUUdmeThHVVRtWUlocmpI?=
 =?utf-8?B?Tk12SGZ2YTg0NGlLYlNoMk9tZ0lVbVF4SE9HMW84NzU1eWtZWUwwY3JyRmRJ?=
 =?utf-8?B?SXNIdzVzaGV3TkovemVCUGFhYjRsYUFSRURFQ0R0bUo4UHFHWUh1WVo4MjQr?=
 =?utf-8?B?NHA4UjRmZTlTOXpvYVdDQ01nN2h5OW9Fam92dHdhNldxeWhMb3h6UUR6OENO?=
 =?utf-8?B?dnN0UC9jYmx3OXRJSkU1MnhXU0VndGc3SXhkdGR4RThNcHdQMHowRDJhTVFT?=
 =?utf-8?B?a0h3Q3NGV2tIRFdUY3J5OS9hRXEyQ2RXY25kcW1vUGR2Q1BpOUVwREJlbE9I?=
 =?utf-8?B?V1QvelZNK2k5Z3NlRHZGZG1PWVJlMTFGcHViRm84MWdHUStyQVhib2VoZXU2?=
 =?utf-8?B?WjJTa05IaUxJblk1NEU1bW9keTk2ZkNJNXRYMk1yQmhkeXpidjF0YzNzM29I?=
 =?utf-8?B?WnIrTit2Tk9wR2xYVVVZcE12MUdLZWFBYjdtQW5iMSs0UkdUZWVpdzN2bWJy?=
 =?utf-8?B?NlpmN3BoZ0RYU3ZCcC9MczhST0ZmVUZqQ3JIWFc5WjVEY2c5WVIrZi9VY0ZI?=
 =?utf-8?B?VnhGR0RzTVE5V0NId3FmSU9YNlAzNk8vdGcyMjVmT0JZOXUrekduVnBIdkJK?=
 =?utf-8?Q?BW0vC5XyNsS0oA2AilWwkMI0M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f762c2e-9c96-4302-34b3-08db8940db5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 16:46:25.4252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qUqh8oezA5jchVrS/iWdMEsvdF8+vq1VaZxFYCUFjQ4Edc4XHWReCNp6GQitWjSrHZNThMHfEKzL4+lKx9l6AsUVLzV9er8/oqfpCvAPfoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_08,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200141
X-Proofpoint-GUID: VTdp9hPGpq4XaaFRcHIgnMsv7Sf48MKd
X-Proofpoint-ORIG-GUID: VTdp9hPGpq4XaaFRcHIgnMsv7Sf48MKd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

KGFkZCBrZXlyaW5nc0AgY2MpDQoNCj4gT24gSnVsIDE3LCAyMDIzLCBhdCAxMToxNSBBTSwgSmFt
ZXMgQm90dG9tbGV5IDxKYW1lcy5Cb3R0b21sZXlAaGFuc2VucGFydG5lcnNoaXAuY29tPiB3cm90
ZToNCj4gDQo+IE9uIE1vbiwgMjAyMy0wNy0xNyBhdCAxNzo1NiArMDEwMCwgRGFuaWVsIFAuIEJl
cnJhbmfDqSB3cm90ZToNCj4+IE9uIE1vbiwgSnVsIDE3LCAyMDIzIGF0IDEyOjA4OjI2UE0gLTA0
MDAsIEphbWVzIEJvdHRvbWxleSB3cm90ZToNCj4+PiBPbiBUaHUsIDIwMjMtMDctMTMgYXQgMTU6
NTIgKzAyMDAsIEFyZCBCaWVzaGV1dmVsIHdyb3RlOg0KPj4+PiAoYWRkIGxpbnV4LWVmaUAgY2Mp
DQo+Pj4gDQo+Pj4gVGhhbmtzIGZvciB0aGF0LCBzaW5jZSB0aGlzIGlzIHJlYWxseSBFRkkgcmVs
YXRlZCByYXRoZXIgdGhhbiB4ODYuDQo+PiANCj4+IHNuaXANCj4+IA0KPj4+IFRoZSBwcm9ibGVt
LCBhcyBJIHNlZSBpdCwgaXMgaWYgdGhlIGRpc3Ryb3MgZ2l2ZSB0aGUga2VybmVsIGFuDQo+Pj4g
LnNiYXQgc2VjdGlvbiwgdGhhdCBtZWFucyBhbnkgdmFuaWxsYSBrZXJuZWwgdGhhdCdzIGJ1aWx0
IGJ5IGEgdXNlcg0KPj4+IGFuZCBzaWduZWQgYnkgdGhlaXIga2V5IG5vdyB3b24ndCB3b3JrIChl
dmVuIGlmIHRoZWlyIGtleSBpcyBpbg0KPj4+IE1vSykgYmVjYXVzZSBpdCB3b24ndCBoYXZlIGFu
IHNiYXQgc2VjdGlvbiAuLi4gYW5kIHRoZSBzYmF0DQo+Pj4gbWVjaGFuaXNtIGlzIGNvbXBvbmVu
dCBzcGVjaWZpYywgbm90IGtleSBzcGVjaWZpYywgc28gdGhlIHNpZ25lcg0KPj4+IGhhcyBubyBj
aG9pY2UgYnV0IHRvIGFkb3B0IGl0Lg0KPj4gDQo+PiBBRkFJQ1QsIHRoYXQgcHJvYmxlbSBvbmx5
IGV4aXN0cyBmb3IgYmluYXJpZXMgZGlyZWN0bHkgaW52b2tlZA0KPj4gZnJvbSBzaGltLiBTbyB0
aGF0IHdvdWxkIGJlIGEgcHJvYmxlbSBmb3IgdGhlIGJvb3QgbG9hZGVyIChncnViKSwNCj4+IG9y
IGEga2VybmVsIGltYWdlIGJlaW5nIGJvb3RlZCBkaXJlY3RseSB3aXRob3V0IGEgYm9vdGxvYWRl
cg0KPj4gcHJlc2VudC4NCj4gDQo+IFdlbGwsIGN1cnJlbnRseSwgeWVzOyB0aGF0J3MgdGhlIGlu
X3Byb3RvY29sIGNoZWNrIGluDQo+IHNoaW0uYzp2ZXJpZnlfc2JhdF9zZWN0aW9uKCkuICBIb3dl
dmVyLCBJIHdhcyBhc3N1bWluZyBiYXNlZCBvbiB0aGlzDQo+IHRocmVhZCwgdGhhdCB0aGF0IHdh
cyBiZWluZyB0aWdodGVuZWQgdXAgKGVpdGhlciBiZWNhdXNlIHBlb3BsZSBhcmUNCj4gbW92aW5n
IGF3YXkgZnJvbSBncnViIG9yIGJlY2F1c2UgdGhlIHNoaW0gdmVyaWZpZXIgcHJvdG9jb2wgd291
bGQNCj4gZW5mb3JjZSBpdCkgYXMgeW91IGltcGx5IGJlbG93Lg0KPiANCj4+IEZvciBrZXJuZWwg
YmluYXJpZXMgaW52b2tlZCBpbmRpcmVjdGx5IGJ5IHRoZSBib290IGxvYWRlciwgdGhlDQo+PiB1
c2Ugb2YgU0JBVCBpcyBjdXJyZW50bHkgb3B0aW9uYWwuIGllIG1pc3NpbmcgU0JBVCByZWNvcmQg
d291bGQNCj4+IGJlIHRyZWF0ZWQgYXMgc3VjY2Vzcy4NCj4+IA0KPj4gVGhpcyB3YXMgYSBwcmFn
bWF0aWMgd2F5IHRvIGludHJvZHVjZSBTQkFUIHN1cHBvcnQgYXMgaXQgb25seQ0KPj4gaW1wYWN0
ZWQgZ3J1YiBhdCB0aGF0IHRpbWUuDQo+PiANCj4+IE9uY2UgYSBkaXN0cm8gc3RhcnRzIGFkZGlu
ZyBTQkFUIHRvIHRoZWlyIGtlbnJlbHMgdG9vIHRob3VnaCwgd2UNCj4+IGNhbiBmb3JzZWUgdGhh
dCB0aGV5IHdvdWxkIGxpa2UgdG8gZW5mb3JjZSBTQkFUIGZvciB0aGUgd2hvbGUNCj4+IGJvb3Qg
Y2hhaW4sIHRvIHByZXZlbnQgcm9sbGJhY2sgdG8gcHJldmlvdXNseSBzaWduZWQgYmluYXJpZXMN
Cj4+IHRoYXQgbGFja2VkIFNCQVQgaW5mby4NCj4+IA0KPj4gVGhpcyBwb2xpY3kgY291bGQgYmUg
ZW5mb3JjZWQgcGVyIGtleSB0aG91Z2guIGVnIHJlcXVpcmUgU0JBVA0KPj4gZm9yIGFueXRoaW5n
IHZlcmlmaWVkIGFnYWluc3QgdGhlIHZlbmRvciBrZXkgdGhhdCdzIGNvbXBpbGVkIGludG8NCj4+
IHNoaW0sIGJ1dCBub3QgcmVxdWlyZSBTQkFUIGZvciBiaW5hcmllcyB2ZXJpZmllZCB3aXRoIHRo
ZSBNb0sNCj4+IGVudHJpZXMuDQo+IA0KPiBUaGF0IG1pZ2h0IHdvcmssIGJ1dCBpdCdzIG5vdCBj
dXJyZW50bHkgaW4gdGhlIHNoaW0gY29kZSBiYXNlLiAgSXQgYWxzbw0KPiB3b3VsZG4ndCB3b3Jr
IGZvciBTVVNFIEkgc3VzcGVjdDogdGhleSBhY3R1YWxseSBwdXQgYWxsIG9mIHRoZWlyIGRpc3Ry
bw0KPiBrZXlzIGludG8gTW9rTGlzdCAoc28gdGhlIG1hY2hpbmUgb3duZXIgaGFzIHRvIGFwcHJv
dmUgYW55IFNVU0Uga2V5DQo+IHVwZGF0ZSksIHNvIGhvdyBjYW4gc2hpbSB0ZWxsIHRoZSBkaWZm
ZXJlbmNlIGJldHdlZW4gbXkga2V5IGFuZCB0aGVpcg0KPiBrZXk/DQo+IA0KPj4gVGhlIHVzZXIg
c3BlY2lmaWMgTW9LIGVudHJpZXMgZG9uJ3QgaGF2ZSBzdWNoIGEgY29tcGVsbGluZyB1c2UNCj4+
IGNhc2UgZm9yIFNCQVQsIHNpbmNlIGlmIHRoZXkgbmVlZCB0byByZXZva2Ugb2xkIGJpbmFyaWVz
LCB0aGUNCj4+IGVuZCB1c2VycyBhbHdheXMgaGF2ZSB0aGUgZWFzeSBmYWxsYmFjayBvcHRpb24g
b2YganVzdCByb3RhdGluZw0KPj4gdGhlaXIgc2lnbmluZyBrZXlzIGFuZCBzd2l0Y2hpbmcgb3V0
IHRoZSBlbnJvbGxlZCBrZXkgaW4gTW9LLg0KPj4gDQo+PiBUaGUgY2hvaWNlIG9mIHdoZXRoZXIg
dG8gbWFuZGF0ZSBTQkFUIGZvciBiaW5hcmllcyBzaWduZWQgd2l0aA0KPj4gYSBNb0sgZW50cnks
IGNvdWxkIGJlIHNldCBieSB0aGUgZW5kIHVzZXIgdGhlbXNlbHZlcyBhdCB0aGUgdGltZQ0KPj4g
dGhlaXIgZW5yb2xsIHRoZWlyIHNpZ25pbmcgY2VydCBpbiB0aGUgTW9LIERCLg0KPiANCj4gV2Vs
bCwgSSBhZ3JlZSB3aXRoIHRoaXMsIHNpbmNlIGl0IHdhcyBteSBvcmlnaW5hbCBwb2ludC4gIEhv
d2V2ZXIsIGENCj4ga2V5IG9ic2VydmF0aW9uIHN0aWxsIHNlZW1zIHRvIGJlIHRoYXQgbm9uZSBv
ZiB0aGlzIGV4Y2VwdGlvbiBwcm9wb3NhbA0KPiBpcyBhY3R1YWxseSBjb2RlZCBhbnl3aGVyZSwg
c28gaWYgc2hpbSBkb2VzIHRpZ2h0ZW4gdXAgc2JhdA0KPiB2ZXJpZmljYXRpb24sIGV2ZXJ5b25l
IGN1cnJlbnRseSBnZXRzIGNhdWdodCBieSBpdCAoYW5kIGlmIGl0IGRvZXNuJ3QNCj4gdGhlbiB0
aGUga2VybmVsIGRvZXNuJ3QgbmVlZCBhbiBzYmF0IHNlY3Rpb24pLg0KPiANCj4gSSByZWFsbHkg
dGhpbmsgaWYgdGhpcyBleGNlcHRpb24gcHJvcG9zYWwgaXMgd2hhdCBldmVyeW9uZSBpcyBwbGFu
bmluZywNCj4gdGhlbiB5b3UgY2FuIHNpbXBseSBsZWF2ZSB0aGUgdXBzdHJlYW0ga2VybmVsIGFs
b25lLCBzaW5jZSBpdCB3b24ndA0KPiByZXF1aXJlIHNiYXQgaW5mb3JtYXRpb24gdW5sZXNzIGlu
Y29ycG9yYXRlZCBpbnRvIGEgZGlzdHJvLg0KPiANCj4gU28gdGhlIGRpcmVjdGlvbiBmb3J3YXJk
IHNlZW1zIHRvIGJlIHRvIGdldCB0aGlzIGV4Y2VwdGlvbiBwcm9wb3NhbA0KPiBjb2RlZCB1cCBh
bmQgYWdyZWVkIGFuZCB0aGVuIHdlIGNhbiBkZWNpZGUgYmFzZWQgb24gdGhhdCB3aGV0aGVyIHRo
ZQ0KPiB1cHN0cmVhbSBrZXJuZWwgbmVlZHMgdG8gY2FyZS4NCg0KSSBhZ3JlZSB3aXRoIEphbWVz
IGluIHRoZSBwcmV2aW91cyB0aHJlYWQ7ICBhZGRpbmcgdGhlIFNCQVQgc2VjdGlvbiB0bw0KdGhl
IGtlcm5lbCBzaG91bGQgYmUgaGFuZGxlZCBieSB0aGUgc2lnbmluZyB0b29scy4gSXQgcmVhbGx5
IGRvZXNuJ3QgbmVlZCB0byANCmJlIGluY2x1ZGVkIGluIHRoZSBtYWlubGluZSBrZXJuZWwgY29k
ZS4gSSBhbHNvIGFncmVlIHdpdGggdGhlIHNlbnRpbWVudCB0aGF0IA0KbWFpbmxpbmUgYW5kIHRo
ZSBzdGFibGUgYnJhbmNoZXMgc2hvdWxkIG5vdCBoYXZlIFNCQVQgdmVyc2lvbnMgYXR0YWNoZWQg
DQp0byB0aGVtLiBUaGVzZSBhcmUgdGhpbmdzIGRpc3Ryb3Mgc2hvdWxkIGJlIHJlc3BvbnNpYmxl
IGZvciBpbmNsdWRpbmcgaW4gdGhlaXIgDQprZXJuZWwgaWYgdGhleSB3YW50IHRvIGhhdmUgU0JB
VCBzdXBwb3J0Lg0KDQpJZiBhIGRpc3RybyBhZGRzIGEgU0JBVCBzZWN0aW9uIHRvIGVpdGhlciB0
aGVpciBVS0ksIG9yIGlmIGtlcm5lbCBTQkFUIGVuZm9yY2VtZW50IA0KaXMgdHVybmVkIG9uIGZy
b20gR1JVQjIgYnkgZGVmYXVsdCwgdGhlcmUgaXMgb25lIHBpZWNlIG1pc3NpbmcgdGhhdCB3b3Vs
ZCBuZWVkIA0KdG8gYmUgaGFuZGxlZCBieSB0aGUgbWFpbmxpbmUga2VybmVsIHdoaWNoIGlzIFNC
QVQgZW5mb3JjZW1lbnQgZm9yIGtleGVjLiBUaGlzIA0Kd291bGQgbWVhbiB0aGUgcmV2b2NhdGlv
bnMgU0JBVCBwcm90ZWN0IGFnYWluc3Qgd291bGQgbmVlZCB0byBiZSByZWZlcmVuY2VkIA0KYmVm
b3JlIGRvaW5nIHRoZSBzaWduYXR1cmUgdmFsaWRhdGlvbiBpbiBrZXhlYy4gSWYgdGhpcyBpcyBu
b3QgYWRkZWQsIGFueSBkaXN0cm8gdGhhdCANCmFsbG93cyBrZXhlYyByZWFsbHkgZG9lc27igJl0
IGhhdmUgYSBTQkFUIHByb3RlY3RlZCBrZXJuZWwuDQoNClByb3Bvc2FsIGZvciBTQkFUIGtleGVj
IHByb3RlY3Rpb246DQoNCkxpbnV4IGNvbnRhaW5zIGEgbWFjaGluZSBhbmQgYSBwbGF0Zm9ybSBr
ZXlyaW5nLiBUaGUgcGxhdGZvcm0ga2V5cmluZyBjb250YWlucyANCmtleXMgdGhhdCBhcmUgaW4g
dGhlIFVFRkkgU2VjdXJlIEJvb3QgREIuIFRoZSBtYWNoaW5lIGtleXJpbmcgY29udGFpbnMgYWxs
IHRoZSANCk1hY2hpbmUgT3duZXIgS2V5cyAoTU9LKS4gVG9kYXksIE1PSyBrZXlzIGFyZSBhIGNv
bGxlY3Rpb24gb2Yga2V5cyANCmVtYmVkZGVkIGludG8gc2hpbSBhcyB3ZWxsIGFzIHVzZXIgZW5y
b2xsZWQga2V5cy4gVGhlcmUgaXMgYWxzbyBhIE1PS1ggd2hpY2ggDQpjb250YWlucyByZXZvY2F0
aW9ucyB0aGF0IGN1cnJlbnRseSBnZXQgbG9hZGVkIGludG8gdGhlIGJsYWNrbGlzdCBrZXlyaW5n
Lg0KDQpUaGUgY3VycmVudCBTQkFUIGRvYyBpbXBsaWVzIHRoYXQgdGhpbmdzIHNpZ25lZCBieSBh
IE1PSyBjZXJ0IGNhbiBiZSByZXZva2VkIA0KYnkgU0JBVC4gUHJldmlvdXNseSwgcmV2b2NhdGlv
bnMgY2FtZSBmcm9tIE1PS1guIEluc3RlYWQgb2YgY2hhbmdpbmcgdGhlIA0KY3VycmVudCBNT0sg
dXNhZ2UgaW4gdGhlIGtlcm5lbCwgaG93IGFib3V0IHNoaW0gYWRkaW5nIGEgbmV3IGtleXJpbmc/
IEFueSANCmNlcnQgdGhhdCBpcyBlbWJlZGRlZCBvciBlbnJvbGxlZCBpbnRvIHNoaW0gcmVxdWly
aW5nIFNCQVQgZW5mb3JjZW1lbnQgd291bGQgDQpiZSBjb250YWluZWQgd2l0aGluIHRoaXMgbmV3
IGtleXJpbmcuIFRoZSBvcmlnaW5hbCBNT0sga2V5cmluZyB3b3VsZCBzdGFydCBvdXQgDQplbXB0
eSBpbiBzaGltIChvciBpdCBjb3VsZCBhbHNvIGNvbnRhaW4gZGlzdHJvIGNlcnRzIHVzZWQgdG8g
c2lnbiBvbGRlciBub24tU0JBVCANCmtlcm5lbHMgZm9yIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5
KS4gSWYgdGhlIGVuZHVzZXIgd2FudHMgdG8gZW5yb2xsIHRoZWlyIG93biBrZXkgDQp0byBib290
IGEgY3VzdG9tIHNpZ25lZCBrZXJuZWwsIG5vdGhpbmcgY2hhbmdlcy4gV2hlbiB0aGUgbWFjaGlu
ZSBib290cywgc2hpbSANCnJlZmVyZW5jZXMgYm90aCBrZXlyaW5ncy4gTU9LIGtleXMgZG8gbm90
IHJlcXVpcmUgU0JBVCBlbmZvcmNlbWVudCwgdGhlIHNoaW0gDQpTQkFUIGtleXJpbmcgZG9lcy4g
V2hlbiBMaW51eCBib290cywgTU9LIGtleXMgZ28gaW50byB0aGUgbWFjaGluZSBrZXlyaW5nLiAN
CkxpbnV4IHRoZW4gYWRkcyBzdXBwb3J0IGZvciBhIG5ldyBrZXlyaW5nIHRoYXQgbG9hZHMgdGhl
IGtleXMgcmVxdWlyaW5nIFNCQVQgDQplbmZvcmNlbWVudCAoY2FsbGluZyBpdCB0aGUgc2JhdCBr
ZXlyaW5nIGZvciBub3cpLiBEdXJpbmcga2V4ZWMgdGhlIG1hY2hpbmUsIA0KcGxhdGZvcm0sIGJ1
aWx0aW5fdHJ1c3RlZCwgc2Vjb25kYXJ5IGFuZCBuZXcgc2JhdCBrZXlyaW5nIGFsbCBnZXQgcmVm
ZXJlbmNlZC4gVGhlIA0KbWFjaGluZSwgYnVpbHRpbiwgYW5kIHNlY29uZGFyeSBrZXlyaW5ncyBk
byBub3QgcmVxdWlyZSBTQkFUIGVuZm9yY2VtZW50IGZvciANCmtleGVjLiBCb3RoIHRoZSBwbGF0
Zm9ybSBhbmQgc2JhdCBrZXlyaW5nIHJlcXVpcmUgU0JBVCBlbmZvcmNlbWVudC4NCg0KVGhpcyB3
b3VsZCBhbGxvdyBkaXN0cm9zIHRvIHNpZ24ga2VybmVscyB1c2luZyB1cGRhdGVkIHNpZ25pbmcg
dG9vbHMgdGhhdCBhcHBlbmQgdGhlIA0KcHJvcGVyIFNCQVQgaW5mb3JtYXRpb24uIEl0IGFsbG93
cyBkaXN0cm9zIHRvIHN1cHBvcnQgbm9uLVNCQVQga2VybmVscyBpdCBwcmV2aW91c2x5IA0Kc2ln
bmVkIGZvciBiYWNrd2FyZHMgY29tcGF0aWJpbGl0eS4gSXQgbGVhdmVzIHRoZSBtYWlubGluZSBr
ZXJuZWwgb3V0IG9mIG5lZWRpbmcgdG8gDQpoYXZlIGEgU0JBVCBsZXZlbCBvciBldmVyIG1haW50
YWluaW5nIG9uZS4gSXQgYWxsb3dzIGVuZC11c2VycyB0byBlbnJvbGwgdGhlaXIgb3duIA0Ka2V5
cyBhbmQgc2lnbiB0aGVpciBvd24ga2VybmVscyBqdXN0IGxpa2UgdGhleSBjYW4gdG9kYXkuIEl0
IGFsc28gYWxsb3dzIG1haW5saW5lIExpbnV4IA0KdG8gdW5kZXJzdGFuZCBTQkFUIG9ubHkgdG8g
dGhlIHBvaW50IG5lY2Vzc2FyeSB0byBlbmZvcmNlIHRoZSBTQkFUIGxldmVsIGZvciBhIGtleGVj
Lg0KDQo=

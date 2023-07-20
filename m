Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC9E75B62C
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jul 2023 20:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjGTSLP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Jul 2023 14:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGTSLO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Jul 2023 14:11:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11CF13E;
        Thu, 20 Jul 2023 11:11:12 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KFEjUA020459;
        Thu, 20 Jul 2023 18:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+tzbD7A5cF9FxZxMjj862SqET9q2gu/849Uv0dba8G8=;
 b=U7Loynun24Tt5HgMcreb9yeC16DNfLtMOzND8HHvYuYbOrzCuzax04btMOajvA0tuoZW
 phBwXSYDFCOkdJ+IrSYtyezGmbkvB/rC//fofPfFhx5e0+jVJ9FtQnJGnFUlSdgVYGW5
 X89b0923iwLiv42q9gFKoIcGIz80iAKhPxrlvzKVygQ1m6/8p4SxpbBtv0KuMZoV31z8
 8UObODAvr0n6SRXoQrNXlAQ833ntK0vfV0niQur31Xl++CR1cm/O/VHv1KsLYCr+GJKQ
 Y8HmVfbZ8h0hmRM2DCzdr7GP3+O8qKSbyWbsFvFhxcp4ZktifV72KRu8nKSg3zhfHtFA DQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run782cxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 18:10:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KHMlSj000815;
        Thu, 20 Jul 2023 18:10:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw91nsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 18:10:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i06ygyjmUQy3FcKP/ic/IvacbIXwUdEz7eWwSGxplG6GJy8z9PVXWFKOhPZL6Vs3kTQzImkifeLSJOEmaCH7bc6zwAnBhGNAcfp2jz+UyiunQpbBbbV6J1RFKa4b84v9I/vK7c3RVU60rqHj/JdyHy9tLFtwawdzHJIBXOQjlnWid7N7jdHr8vhFz4nXVi6WpME+MDFtybIReCvn4tblDY2H+piqDSoPJFPrwjVcXR0i+HEUAefMrjcKpUbADMMnysOmm5qLfupxGEafDQ+b4erwclTRevhUrfkEHq8w6Wn+SipFcOsdsD/R7mOypGXyARBihGY4TP+Zf9B8mdfeXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tzbD7A5cF9FxZxMjj862SqET9q2gu/849Uv0dba8G8=;
 b=mE51jRa6CamR/DLR/LdmJMSkvr6IugWaSmQaOgW0qLtTahp6kqSwbDWs2lxFgGPkGKQ8WSdxqZIfX/hfUlKrbONasQtiLok9iLrhZmxIyEMBx/+6gegMmqaXKNHg4o5a8FB4fYyAnPsMJHJjImPp6bB5qO2ofVltFCPxVccox0ly+KcFzwK0I7EmaXPyDmZkagY2TynXZnP3ALk0i66ln95UoofVE/dqk3Y8JelElkwocI9lMc/f54m/XAS2IOI1x2ucUfRSxbPY4lJeWBY7OQ48hP3sa1ukmeTar5XfHTu2RcneZI5FM3GnG4gwZefLxv7V054IBvRCYNvkBe3Rhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tzbD7A5cF9FxZxMjj862SqET9q2gu/849Uv0dba8G8=;
 b=o39qRWjWe8iGIVamTeY1dk5bgnX4/pOIViZI7QsEpA9/PRaRR5EJ0xt6ywrnzizwH98GtzTFo9gnxMxk3iEh+5ST/WbvQgFTmHf/2gyLtNW0SvJjt/eitAkPm3mL2BajuWU+lTb21O6k49klVhRB/dwjFAFc8I0jgpXv4ssPkLE=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS0PR10MB7478.namprd10.prod.outlook.com (2603:10b6:8:166::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 20 Jul
 2023 18:10:36 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9beb:8c8f:3c09:a965]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9beb:8c8f:3c09:a965%5]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 18:10:36 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
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
Thread-Index: AQHZtZFPNdQ9vtMEUEOriR3uv4Pj06++JrMAgAANbACAAAVEgIAEruoAgAAF6gCAABGZgA==
Date:   Thu, 20 Jul 2023 18:10:36 +0000
Message-ID: <186450BA-9C7F-41C7-9F97-BA1277AEC9FD@oracle.com>
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <ZK/9MlTh435FP5Ji@gambale.home> <ZLABozIRVGmwuIBf@gambale.home>
 <ba2354dc63fd741d2d351b18d4312d0771c0935d.camel@HansenPartnership.com>
 <ZLVyvAXwtemx1I6p@redhat.com>
 <0aa647f719103e8620d7209cbde40f04a7334749.camel@HansenPartnership.com>
 <FBDC67DD-856F-429B-8E91-B0CA8B0F24B9@oracle.com>
 <d67ac07c71097a4c97c8792c7c1fac9f4d5850dd.camel@HansenPartnership.com>
In-Reply-To: <d67ac07c71097a4c97c8792c7c1fac9f4d5850dd.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|DS0PR10MB7478:EE_
x-ms-office365-filtering-correlation-id: b3ea46a6-3da0-4bb9-1e2a-08db894c9e3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ReYMaO5usiIz1ST1LLXyUZlJ2KHMCHYO4diWFubYd2lqtgfqiIcB/VanlUs/bQYoLlBWtQnydLqLjIdFo3bF7sZu2d4XvzPzycMWECiiuPG2yIBu9isCKY1xmwGW+uJBD7r78LRsDwf1SZ1wIQb7zmhTssMMRuMZof89ET7PQEjLrhfL39lFsuOK/1VmYwg6fm6AqnTEXrGOyUksQa7dpvL/SI0LdwmLJOxEM4mNuXDhYOZxiqfj5+dFBk/4D12V0HmMQIle/kOc3Yzih8ld7ZoHgTA/1PMcOtgzafpvxZ9futXkctYwy6i5rHmjT/F2SozLxehO99sPfHDdUgNcjGIaqIRnxlr7f5sbq9qGGqlCxA1aMANnpY984k2o3SODbIH1TXmKU7iCdCn0bpw7BItcLD8oplJDDuO3Y9WR9FYdfJ1ECB9A8wb276Jd0x7RQKUR5/r4x8YgbL2XfmyGcLsGHry01b1XpxymH5Db9MpPBpdkgioVNsTdcs/w7gg8yit4Ze5imf3dKtrZcctB4FHaNLg1nxiN+zOIvBYJxWP0JEWLXWIBZ2H4/YHL4HjsQk01iF6G6nsljRclIp1TBQnNPFOC/prVEHy1kiioo4XN8LJxSWi/ELLfewC1ws5JbwLAaium6rvEqH1+RrkoQS1M9xz/yRqA1jnOZJ6R12PD8CPKrfZ6l3lUU1TqAeqe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(71200400001)(478600001)(2906002)(122000001)(6512007)(86362001)(83380400001)(26005)(38070700005)(6506007)(2616005)(33656002)(38100700002)(53546011)(5660300002)(7416002)(54906003)(66556008)(44832011)(36756003)(8676002)(6486002)(66476007)(64756008)(76116006)(66446008)(66946007)(6916009)(8936002)(316002)(4326008)(91956017)(41300700001)(186003)(142923001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFlFREVaTkgvbVZ6Y0VYZUpMOVhPU21LYTd2QzY1TE12UGhpZW9ESjRzWHd6?=
 =?utf-8?B?Rm5WWThLVElPVzcvb0RiL0xkNjlxY3MzUTZiVlFBMC9zdmROQzJvVHRjUVJy?=
 =?utf-8?B?SXB6cERneUJOWjBFdU1CbEplekNWa2ZhejdRQ2t1UTMvT1RLdFJxSkl2QS9P?=
 =?utf-8?B?T01VVFZxVHB2bU5OV09UL2dzRU1pMUkrTDAyQTE5djJVVWJiQ2hGSStBN3VE?=
 =?utf-8?B?OWVNa2pEUXdIMzZqK0FUZVZ5QXRIWWR1MWZyOUR4cG1zVTRxNms0S2FCVW1H?=
 =?utf-8?B?MktXNVJTR3JZejJJdStPWmpHdnN3bEFvVk1YTTJuT3dmTStHSzI1blBXcjJW?=
 =?utf-8?B?UTRzTm9EYzZlS0hwNVVtZEZacnJSbEpldERtM0VyaUd3TlgrT1RrejdNOVVm?=
 =?utf-8?B?TmZ2cVBQL1NqYkM5cmpZdlNlN2pkY255V1VmVWI5ZS8xKzJweHh6bFlRNjBY?=
 =?utf-8?B?TmhpeXM0ZktRc1UxNFhoMzJWUHFlYXlUR2NXdlFMV0UvQ0dmTnRkT2V3QU8z?=
 =?utf-8?B?eWQ5V3VZSWNjb0NGNk9XUFovU1dWak4xMGJmK2RIK2RYT21ObWRuRlMzK2ZI?=
 =?utf-8?B?eU5LaVl3TGNqYzZYSk5HNWZES0NkNHhxTVZLNWtsZVlmZUdkenNMSDkxc1Vo?=
 =?utf-8?B?bGFuV3RUcFFRbTV4UzlxWldiSWkyZ2I3bDB5bVVqY0pDMDM4blVBblNsLzNJ?=
 =?utf-8?B?RzA4bkdQRlNRNVd0K1NoTFAxeFljSjFJWUdlQWlLUGd5TU1PSFQ4Qzk1SXov?=
 =?utf-8?B?V2ZxZDUrYkhScWlBdjZnWXVlQlZOUTdoYVlBNktLTUlucGpNYjcyUGVaczkx?=
 =?utf-8?B?MGJCTTBaOU4zcFR6K3dpQlQrSnJZcENtbjZhL2N0VEtMbmNJSTFuWnRxdmZZ?=
 =?utf-8?B?WFA5aDZDbEJHaThGU0JzTWlPTS81QzV1NDBhc0RjbFp1Z0g3dU5QV0l1bDNo?=
 =?utf-8?B?TmllSVdNQ2FOZnJCd3Q1YkxZNEpLMlBsMjZYNTFKSHZ2a2FLdkhsV0lCNms4?=
 =?utf-8?B?RTNURzUwdk1nTUtMUFlpZE9oNFA5a3hUUFJia1ZLTHBPMmN5UllpK1FkSy9j?=
 =?utf-8?B?VUJ6ZThOOTg2UkF1Yi9nUzZBdmhOR3h0dXpwQVl6a1Q1Zm05Q2poL3FENzVa?=
 =?utf-8?B?ZzRPM0R5cXZ5WCtGY1VYR2doWk12dEpJa3hvdWNONmc4YU9VeTVueTFvVjhw?=
 =?utf-8?B?aUhId2NSMTY3VzV4NnAwWGpsYnRTL1BGY2x6M0szaWtNakVGeGRXUmJuaG5N?=
 =?utf-8?B?ZFVMZEFMS0pmeHJ4aUQ3dnVSNUNvSWI3a0U3ZEp5dTY1M1VyT0IxWnZXUkJl?=
 =?utf-8?B?em5KVmxtWkdTbndVcG05RDhZeEdDMlpyTUJRNUlSU2pybW5TSzNhUERNZHVS?=
 =?utf-8?B?ZUVyZGszaFhmdWQrUU9ESW9nd0gwWDliajRIZ01XZE42Q0lWQ1NIaE5sVWps?=
 =?utf-8?B?UXRKUHQ4S0Z5K2FKd0tiYnJuUVVoR3Y0c0xBTytFbERicXBsQThVZ011U21W?=
 =?utf-8?B?NVlROHlFMTBrcldFNzFGUGh1MXRwMTFYdUlKRDF4dThqdVpOa2NHRzJ6T1dP?=
 =?utf-8?B?L1ZUMHlOMm1MbDluMy8rRERGM3JjNFM5bisyZzZSdkc4UjV2emlIRVhiUFMx?=
 =?utf-8?B?Q3JzSW1OWG13NEJ5SG5QTUNjZFU0YkorcG5EYXMzVEVod0JDNGdlTzdKMDlY?=
 =?utf-8?B?WWVMTG1vZWhMUmNhbXZpdVg5aFpJQVZjWHRaQ2FJSlZHUEttckkzVWg1OE5I?=
 =?utf-8?B?dG15UU1pVkJnZVUzdHh2S3BGcms5VEJvaDZIQmkwOWVsQ2RrNVZ5M1Z6WVBN?=
 =?utf-8?B?L1VWRGxlOFpCV0haQU1kajFGeDlmdjllSGZjekdKSGx6d0x1bVpkVFFLWG40?=
 =?utf-8?B?MlkxN0JFeTZhZHhKVWpZMnZEMFlNSzgvcjZvZHJzenlSQm12Y2ZDZzl2eUxT?=
 =?utf-8?B?QTdBTnZyeXdEcXRmWEh4N0dQZEdHdlBLSnZERXRQTEloQ3pORDc4b3RaQWNK?=
 =?utf-8?B?M0hhWGp6R3JYMWhUczBKVDhIMnFlNS9PN2gvV0lWVEZ4ekJ2eFJ2bTl0U0NY?=
 =?utf-8?B?OHVFbjVtZ21VbzhiV2EwSlhVK2lYdnA0K1kweitPNjU3UU5TNVk3bW1HUWJo?=
 =?utf-8?B?RVZUdG1kSHZzYW1ZVk1Hd0t2cFdQNnk5dFZpWEs3S0l2ZzlEZ1lId0Q5eVNK?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A14AE782107D7044B826E2B2DBC78256@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UmtWb1Z1VEQwSkZYUFNnanJoWDd1YzdTWndvb3FOVzh0TUR5cEhsVHFqNSs0?=
 =?utf-8?B?NWQ3MGh0U1RBeGwyZUE0dVpUSnYxTDVVN2x4UFNHQkhSMlU4YjhENzc3UUl6?=
 =?utf-8?B?TEJwV29UWXBLMzhNU0M2b2pTbmVHWlN2ZUM2MFVXOGJRNUdkbkxKZkg3MkQv?=
 =?utf-8?B?cG1ReFNIZDhhTjhXN3l6V0RYbngvOW1Palg2NmR0NjlQRVlGQi84WkYxVzFx?=
 =?utf-8?B?R0czWGhJdW9VUEVqTWlDcmZCV3NtVy8zcWtIU2J0SE9yQWIxemV6TFBQbTN1?=
 =?utf-8?B?bFBFeWgvWE0rSXJNRzNBNWhvV2RaY3FiMGpkTjBocndQaDU3SURYWFVGeG9m?=
 =?utf-8?B?Myt6UHpYWUpZV29yVjJZZEJSVVhGbUpKbVoxdzJUZ1dUVkRhYVhXZU5WMXpK?=
 =?utf-8?B?ZEVFNngxRThDVGxwaWI4V09UMG9kNW8vZ2MrZWhFditweGVSU3JUYUEvMTJ0?=
 =?utf-8?B?aWtERGJWMWcrclpwWVI4NGh4UmprWjlWTjZKSGdzOENnRDRYZ3VRdENLdDNv?=
 =?utf-8?B?dmtCY3ZnaUNxbXJRS3Z4cmhwZkVWbUgxSFV0VHB6bDIxWm5YdzFtLzJ1TnVF?=
 =?utf-8?B?eTZ3OWtOclIvUjhjV0JUVVE1Z0tsOEhvQjYyOFVKMGJUa0tBT1FQelNmckx3?=
 =?utf-8?B?MTRVNGwrdmg4cHcrMXhlWDRRQk53dkxFZU9EOXNIdldXdW5TcmdzWGhmMkpP?=
 =?utf-8?B?STdKcWdpb2Vnc1dOY2Nub2tVdWNVbElhVTUyeEc1QzZ4RmtIeWRiWnp2ZTZM?=
 =?utf-8?B?bGl3VW1rYmsyVFpWQXRHQ2lmeWx2R1pzTEQ0TnQrdnY2cFB5dWZKYVNlblJ4?=
 =?utf-8?B?SEVpdzJoTS9KZVNyZVhSbjg1bUNoVW5WL1NpUUozUElpVUl0QWtpUWt4cFIw?=
 =?utf-8?B?cWwvOEVPZlJPVVpGL0NjTURmNXFKUnhwV0RvbmZDUGlBYTNwbXJFNHhGRi9t?=
 =?utf-8?B?SEtJNHRqRy9WTTdhZ0JZZ0paSEx0VFd4S2ppMzVVQ0VhTTU4cEtMbCtsN0Fs?=
 =?utf-8?B?ZFlSc0hlR0lBNk9XblVSOE52eldMQjVBaG1PN3pnV2NSUk14V09PRFArajBy?=
 =?utf-8?B?ZjhPM25hZmplMVEwbEF2Rm90YXdaVDJJMTBUdHgwZFFXRXkrK0lyZWJMa2No?=
 =?utf-8?B?SnFacndNK3BBd3Zybm9OOWwxYzFkOFRESXNMbWxkZGRtWVhCUEQvV2xqL0Js?=
 =?utf-8?B?b1I1SnZDd2dlVWlsaXJpb1Z3UVNhZjJVeGZCVVUzYmNTYWRKK3hrcEI0NEZF?=
 =?utf-8?B?R3ZGaStnMHVid0ZrOVYrRDRiUmptMlZVNWFFeGdvdGZMYThXalNnTXFkU0JN?=
 =?utf-8?B?dUhWM01zU3dKTW5ZVzZ0TnBYako5eHZsWENhQW9Bdk5UWklNYkV5RkdTcEtV?=
 =?utf-8?B?VThvT0dMWElVdWZGWGhqdkQyNE5wZVBMekRLMnlkZ0tGQnFaSE1vNlloc0dt?=
 =?utf-8?B?UytxK3pOb2QrTDkwanRySWphQXBLc3FKWFdSOFNyOHZ6Y3lLUm0vU2xDcmRh?=
 =?utf-8?B?Z0tSKzRTTmZkeFpKR3c2dGFiZTEweXlkZW5mQWJqRXNmTXhwMnI1TmJ3SDQz?=
 =?utf-8?Q?s0+j+FOHsjOZhKtG2WkPU1UxY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ea46a6-3da0-4bb9-1e2a-08db894c9e3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 18:10:36.8314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D52ZHupuPRPu1FUEsx1elMARH5mWFBcJbxZUEFuSOC49ibrHsqwzw/1QemiKnwG/Tzg4mz1neHcoZgJfhpXwgAn3CC9bovmH/j8AUY316P4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7478
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_09,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=636
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200152
X-Proofpoint-GUID: N6o2IqRA4Q6T-0ktVEXj19RhnGG0IwyN
X-Proofpoint-ORIG-GUID: N6o2IqRA4Q6T-0ktVEXj19RhnGG0IwyN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gT24gSnVsIDIwLCAyMDIzLCBhdCAxMTowNyBBTSwgSmFtZXMgQm90dG9tbGV5IDxKYW1l
cy5Cb3R0b21sZXlASGFuc2VuUGFydG5lcnNoaXAuY29tPiB3cm90ZToNCj4gDQo+IE9uIFRodSwg
MjAyMy0wNy0yMCBhdCAxNjo0NiArMDAwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IElmIGEg
ZGlzdHJvIGFkZHMgYSBTQkFUIHNlY3Rpb24gdG8gZWl0aGVyIHRoZWlyIFVLSSwgb3IgaWYga2Vy
bmVsDQo+PiBTQkFUIGVuZm9yY2VtZW50IGlzIHR1cm5lZCBvbiBmcm9tIEdSVUIyIGJ5IGRlZmF1
bHQsIHRoZXJlIGlzIG9uZQ0KPj4gcGllY2UgbWlzc2luZyB0aGF0IHdvdWxkIG5lZWQgIHRvIGJl
IGhhbmRsZWQgYnkgdGhlIG1haW5saW5lIGtlcm5lbA0KPj4gd2hpY2ggaXMgU0JBVCBlbmZvcmNl
bWVudCBmb3Iga2V4ZWMuIFRoaXMgIHdvdWxkIG1lYW4gdGhlIHJldm9jYXRpb25zDQo+PiBTQkFU
IHByb3RlY3QgYWdhaW5zdCB3b3VsZCBuZWVkIHRvIGJlIHJlZmVyZW5jZWQgIGJlZm9yZSBkb2lu
ZyB0aGUNCj4+IHNpZ25hdHVyZSB2YWxpZGF0aW9uIGluIGtleGVjLiBJZiB0aGlzIGlzIG5vdCBh
ZGRlZCwgYW55IGRpc3RybyB0aGF0IA0KPj4gYWxsb3dzIGtleGVjIHJlYWxseSBkb2VzbuKAmXQg
aGF2ZSBhIFNCQVQgcHJvdGVjdGVkIGtlcm5lbC4NCj4gDQo+IFVtLCBhY3R1YWxseSwgdGhpcyBp
cyBhY3R1YWxseSBvbmUgb2YgdGhlIG1pc3VuZGVyc3RhbmRpbmdzIG9mIHRoZQ0KPiB3aG9sZSB0
aHJlYWQ6IHNiYXQgaXMgYSByZXZvY2F0aW9uIG1lY2hhbmlzbSBmb3IgcHJvdGVjdGluZyBFRkkg
Ym9vdA0KPiBzZWN1cml0eS4gIEl0J3MgZGVzaWduIGlzIHRvIHByZXZlbnQgbWFsaWNpb3VzIGFj
dG9ycyBleHBsb2l0aW5nIGJ1Z2d5DQo+IGNvZGUgdG8gZ2V0IGludG8gdGhlIEVGSSBib290IHN5
c3RlbSBiZWZvcmUgRXhpdEJvb3RTZXJ2aWNlcyBpcyBjYWxsZWQNCj4gYW5kIG5vdGhpbmcgbW9y
ZS4gIFRoZSBrZXJuZWwncyBpbnRydXNpb24gaW50byBFRkkgYm9vdCBzZWN1cml0eSBpcw0KPiB0
aW55OiBpdCdzIGJhc2ljYWxseSB0aGUgRUZJIHN0dWIgdXAgdG8gRXhpdEJvb3RTZXJ2aWNlcywg
c28gZXZlbiBpZg0KPiB0aGUga2VybmVsIHdlcmUgdG8gaGF2ZSBhbiBzYmF0IG51bWJlciBpdCB3
b3VsZCBvYnZpb3VzbHkgYmUgdW5kZXIgdGhlDQo+IGNvbnRyb2wgb2YgdGhlIG1haW50YWluZXJz
IG9mIG9ubHkgdGhhdCBjb2RlIChpLmUuIEFyZCkgYW5kIGl0IHdvdWxkDQo+IG9ubHkgcmV2IGlm
IHdlIGFjdHVhbGx5IGZvdW5kIGEgdXNhYmxlIGV4cGxvaXQgaW4gdGhlIGVmaSBzdHViLg0KPiAN
Cj4gQXMgZmFyIGFzIGtleGVjIGlzIGNvbmNlcm5lZCwgRXhpdEJvb3RTZXJ2aWNlcyBpcyBsb25n
IGdvbmUgYW5kIG5vdGhpbmcNCj4gYSBmdXR1cmUga2V4ZWMnZCBrZXJuZWwgY2FuIGRvIGNhbiBh
bHRlciB0aGF0LCBzbyB0aGVyZSdzIG5vIEVGSQ0KPiBzZWN1cml0eSBiZW5lZml0IHRvIG1ha2lu
ZyBrZXhlYyBzYmF0IGF3YXJlLCBhbmQgdGh1cyBpdCBzZWVtcyB0aGVyZSdzDQo+IG5vIG5lZWQg
dG8gZG8gYW55dGhpbmcgYWJvdXQgaXQgZm9yIGtleGVjLiAgTm93IGlmIHdlJ3JlIGludGVyZXN0
ZWQgaW4NCj4gc2JhdCBhcyBhIG1vcmUgZ2VuZXJhbCByZXZvY2F0aW9uIG1lY2hhbmlzbSwgdGhh
dCBtaWdodCBjaGFuZ2UsIGJ1dCBJDQo+IHRoaW5rIHNiYXQgaXMgdG9vIHRpZ2h0bHkgZGVzaWdu
ZWQgZm9yIHRoZSBwcm9ibGVtcyBvZiBFRkkgdmFyaWFibGVzIHRvDQo+IGJlIG1vcmUgZ2VuZXJh
bGx5IHVzZWZ1bC4NCg0KSWYgdGhlIGxpbmUgb2YgcHJvdGVjdGlvbiBTQkFUIHByb3ZpZGVzIGVu
ZHMgYXQgRUJTIHRoZW4gSSBhZ3JlZSwga2V4ZWMgDQpzdXBwb3J0IHdvdWxkIG5vdCBiZSBuZWVk
ZWQuICBXaGlsZSByZWFkaW5nIHRoZSBTQkFUIHNwZWMsIEkgZ290IHRoZSANCmltcHJlc3Npb24g
dGhlIHJldm9jYXRpb24gbWVjaGFuaXNtIGl0IHByb3ZpZGVzIHdvdWxkIGdvIGJleW9uZCB0aGUg
DQpFQlMgbGluZS4gIEkgZ3Vlc3MgdGhhdCBuZWVkcyB0byBiZSBjbGFyaWZpZWQuDQoNCg==

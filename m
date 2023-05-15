Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4449C703C63
	for <lists+linux-efi@lfdr.de>; Mon, 15 May 2023 20:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245122AbjEOSTS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 May 2023 14:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245146AbjEOSSV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 May 2023 14:18:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3402C1899A;
        Mon, 15 May 2023 11:17:24 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGoUZR029093;
        Mon, 15 May 2023 18:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=t+BAbbV9MF/cfI/jorGeLlbeMAF42g0Db+dEb3B33Kw=;
 b=p0AebR6Pes6Lu172D+2CYk+v3C9KB7wbaf/5Rj+Mfz+5BIqWhSb5HNMR+MHLSHoHU9Up
 Lpp3JzzmbpBGubnNhd+ZaIltlpoTWmE4bdhQ96uLBFre6Gt8b3f19alrd+dxIm9oJrcH
 m6+6X+yyo4fr/MqgZI6fwbNPlzcFAYVTihDeHJSUdGoSXA4bPh9VTCML3XV489uOmuMs
 ty74lNgr26rHtasfp86u2dWKXT7dDvK4ibVVCmG1VgvPinvnIUKpTCbpyu+rMPkC9KQb
 O2YrH3v0bQlVswTzt5FuwxeXGcuByebCrH/jRQG8R0r8ChA934yKMFGcUqTupiZr7o5G 3g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2eb0c9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 18:16:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGiGfO036751;
        Mon, 15 May 2023 18:16:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10993y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 18:16:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dqq8puicltIhMoOhtNm766TtvMpQQbna7UzFKq53UCK9gXVpTqc1iBxGKAV+qEpR47YG7iZLW1Kk5yv3zSZs3lRa9Ga/GvvwbXxq4KkMd/+o3fl3p9H3h3RYHE6ZWSXLC9xhbY2sTEqyzHeYRXkUx2YYxNLjnoPY7fU2lngrud+2jQZAJ+WFlhr1FGbfaoxcXjRVzW8zftUIiGnYKdGOXtPiEe/m3DL2gZ053YuSQeUagZ8w0LihKky7eklvErX4C5o3wy0AnX/n+pQMDR6EePzSr+OE8q54BvjJtgdlU7oiQDOGEkI9ja5hhkGvUDRI0b53JQljn37RMYKuBbBMvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+BAbbV9MF/cfI/jorGeLlbeMAF42g0Db+dEb3B33Kw=;
 b=khaY3AP2wfJOLN6xULZJifFloepgXny3V0KCzLbpf0Xndzt9IRIucTgWzrepJ7eNn7HEptjkztoECTn/UHSaQWyg/3+5Uz0rQFNw2O5chEwho7hF2tTridS1JY5WJy/lMEGFipP4fFoY9u/omPS5GY9QjIEnvqGxVYe3DXvu+D+sOox3ZfdnKWwc2EoBjYJfh8MX0Jd2gh3Yf+P7Cfhj5J5GNUJ4okJdh8+UQ1IHJ1hxBIQGCt7S4pgo5hDYqdA66q+ysuZkJJI1guh/SOIrsibPxuQs9C8j5OznRTXc0kJlg4JG3L7gfqgPFSgknajmPIcZPhfXGbJ6g9gzdB8EkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+BAbbV9MF/cfI/jorGeLlbeMAF42g0Db+dEb3B33Kw=;
 b=s4b41QqK67lb3e7trZvqtknh9+75P7KzF/tTWFevuvPLQwnCKasC/2eQ6QOilqeZXl3fSmMkmJB7+kjUnFB3yibyDRpF/mB+4icfKInOmarrJzd5jhT5j70bNWmeruQmmF1zF11mCVCzW/FKeo0tcovlmdYiw1mdWMtsiPr9s+M=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by CO1PR10MB4545.namprd10.prod.outlook.com (2603:10b6:303:9a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 18:16:44 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37d1:ec08:a280:1d91]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37d1:ec08:a280:1d91%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 18:16:44 +0000
Message-ID: <a38e0589-fa20-77ac-2fb0-2cb247c2b408@oracle.com>
Date:   Mon, 15 May 2023 14:16:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 11/14] reboot: Secure Launch SEXIT support on reboot
 paths
Content-Language: en-US
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-12-ross.philipson@oracle.com>
 <20230512114000.GG14461@srcf.ucam.org>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <20230512114000.GG14461@srcf.ucam.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0040.namprd20.prod.outlook.com
 (2603:10b6:208:235::9) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|CO1PR10MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb6e046-fd8a-45f0-8baf-08db557089de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: klWbMHqxH+m98+IkoHnOZKiHQ0fNU9/2yRK5uq9QMCPFtyje6087nOxQYLKw4BnCwP9kfg61QgTJQ8eghRQum0cfRcZ1DVVHszpjmZKVdNb+YVVr85wjNBl3ZgtXR4/PlsyqxoQZFHYoo2Cl9IpESHpvwJ8oVnZwk3Jg2Qf7wtcLrVADBEnOur6FH04O4ESf5KuLedUHQ/wVQT5kSURykWSKmXhBrUTa/ksMDTZ81S9iJtWQ9zvtNs9avvhkYxnn6x6IMP54yC4uV5Wu7YE7aqhDnQeDKddpM8n45A2nEWUuo+7vqPjRfhE2B1OcDIbJTs2mBou5Ogf2/Mzaclz8ZSbXeb0P7PGztlOeyymfMQOiNF+aRjNpk8r8KKP77moRz7AcXz8fvzwyT1fMXuKSVpqsguILIxGKD3Ud4D8ZwBDXYZAlz4mSu1AxQ6EPmis0U2WqtJVyVEoMN3dYB2gX13abSo0HcZokNoH4qAPKql7zQz5jwpwD8TEuRjnqd8q8Hqg+1kIZ4z/HFSE39FYCKPHAbff0+G9QYH29bbSS66hcd3jxXBq9PD4RUS0CXSJI7b2Gb79o/MhMNiEQOni0iJpf5d7rnHocQv0Oli3qJucQZUKpq4T7SvqMbhuFT8OptjtbiVY8U5dn8r4ctVsDMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199021)(31686004)(6486002)(478600001)(6666004)(53546011)(6506007)(6512007)(7416002)(2616005)(86362001)(36756003)(31696002)(6916009)(4326008)(316002)(186003)(2906002)(4744005)(38100700002)(8676002)(66476007)(8936002)(41300700001)(66946007)(66556008)(44832011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UCtudXgzTUR2WGZFbU9hdi9yeDBIaFJlZjQ5aDc5QVJQVkpkcFFYSit3M3pJ?=
 =?utf-8?B?QkU5V09WbndWV0xXMmhPVXRlUVdoZlVjY2dXUHJqK01iZFdsN3lEQmhuQjhQ?=
 =?utf-8?B?aVhvWCtvZVNHM0IzQnFLOWY2TmVtN2c3WkN3QTliQWIzQXd1K0JFc0lFZlF0?=
 =?utf-8?B?dFFRTGhMYXFIS1BTaFJ0RGM5NWluY3h1REg5ZGM3ejFBWUpUdUlrSEhXQkJD?=
 =?utf-8?B?T1I5b0hrcjFleStSWERtUE5nSG5XOEg0V1F2LzRtZkNVYW84ZSt4LzFuRDh0?=
 =?utf-8?B?cGgweGl3ZlJiY0xpWERvWlU0MUtiUzFXeFhMZ1V0bTl4RStNMEpzMWp0NytJ?=
 =?utf-8?B?WmJlcTBzb2ViS0hFL2VWdjdBSEVuQ292QW9lVjhJTXpydEJZSGFRY09iKzFp?=
 =?utf-8?B?VWN5VTZzMFc1VS80anRtQ01Jd3M0c2VZQVNBS1RjZFFUbWlOajRBSENkTDJp?=
 =?utf-8?B?Mmt4TkRBUE1RS0Yya1QrQWdSbnNSTFNqdDY2TVhRbFFtMGUyKytKbElYYzBY?=
 =?utf-8?B?RHFDT1BJcDdwV0I4ZVN6UmVaM0d4MkExWWxGRmdvTCtyN3V5WEw4eVdGcVQw?=
 =?utf-8?B?VU1FSE1yTkpRR3RsMlJhbXo2Z3BGWnF6WHdtZGxLbFFBY0pYNklrTFpKNXBP?=
 =?utf-8?B?TGViaTRrUzRMUGtWbjFncXpuMmtIRVJoM3RxRm50czF2Vmp3b1dPNFNvS1FQ?=
 =?utf-8?B?dldSODB6bFQ0YmlxN1lLTVpaOGZsUHIvQVR3ZDgwSnBaWmVxMWRCQW04ZGRu?=
 =?utf-8?B?MnI1NENGYkduaHdZNFRYdUpRb3pmcHJrU0tHWmxGa0ovVDlhck4yK29KdHVB?=
 =?utf-8?B?T3d3UzZjeE1IYmZNQk1GcW8vWWc1YUtyTzFpS3dxMmFkT2VNQi9GcEUrcXBP?=
 =?utf-8?B?WE1PNjFrVHBYUGdueXcyTXZ2aFdzNjJBK29yTGJJRlpkTUxIemJGT00wZnZR?=
 =?utf-8?B?d3I1Y3dDT0cwVXRkNWVvV3laWmMwalZJT293N1B3ZmRIaEJRc1NaNGdURnpa?=
 =?utf-8?B?eWpYWlg1aWRoR2tJNm0rcDlzdjdKRjVqK0pnYnFvQXFtaGlzalhiWExJekJY?=
 =?utf-8?B?SVQzOERnVzluWWdwUUxtekFHSiszWnpFTTRDYVpsT1J5dXJUWEZzMVNBQ3ZT?=
 =?utf-8?B?eFF4dDZCYmFTekZqNVk0anZsVkQyTnZadndmUkVtR0ZhVTdGK3NGK21HQ0Z4?=
 =?utf-8?B?L2tIQ3dMaGJkRnJxeDdMRHFTZUlsZnVWOTNHZ2paT2RxVm01c2c4dzhDeUFj?=
 =?utf-8?B?N215UDFJTEgrWUFCaHdhVlNjRGl2RjR1NlllUmxrV1dUZ3FnR3BSZUx5MEEr?=
 =?utf-8?B?ZEJjTUxNSmZCNFZtTDhMZ2RqSEpRcEM0R3hUVkdHcU5GTnpXTHZ4c1hFekl6?=
 =?utf-8?B?QkR4MitFNWYwNit4ZW5LVm13YmJUbndmOGZGSURXQTd2SWV5bTlOb2JzTnNQ?=
 =?utf-8?B?eG5wd0xFMUlPOC8raG84L1BjNXpING1mWmc5dWY3SFgrTkxna0UzYS9Yd0Vz?=
 =?utf-8?B?OXYzTlphZnpVVFh4TkxNQzlEZXRpY1FCZW9wZjErUDV4WFA3eDRqMG03Z1FW?=
 =?utf-8?B?NHgrY09XRnVZWmF2aVdhamxKdGttZEFZckRxRTlpTkc2bFhZUXEvaWx6bGVB?=
 =?utf-8?B?eXF3bjUzS2EreWZyQ1V4QTUwWGN4YXJVNy9sd2pGelZpdjlvK2JnbmJ5SURE?=
 =?utf-8?B?aTQyNFh2NlcwSmVtdGVVaXRPUGZTMlExemtyTTdTK0pTUVZTbUhnWVpaMGxp?=
 =?utf-8?B?NGlZUzFWbG53Unh4TktCR3g1S0s1c3lVMWp3eUx4UGNzc3RoYVcwQXZyeVFj?=
 =?utf-8?B?S1hodUlnWEkvbVpYTWY0UTdpdlZqakZTMlRJZnNqeFJyQXg2L1FTZUNITEJQ?=
 =?utf-8?B?cFE0OSthRE9iNWY2VGFZR1JBUFNtRU02MXZ6d0U5WEZIejJwQlBKdGpTUTdy?=
 =?utf-8?B?YUVVN0tGenZBNXRZc1pGcjk1ZmZUelBsWjZWVDVsWmxJNTJHZ0xITjN2eDZo?=
 =?utf-8?B?ZDRObmRJU1NtVjF5aXlOd242NU5JRXVYam9Cc2o3UGZkdWtpTUVvUUgzdEk4?=
 =?utf-8?B?RHRWc2dVcExmN09SK0FTOVdxeTR6UWEzeXg0VFdyUUVlcmJVWDRyMGlvcDl3?=
 =?utf-8?B?Wkw3ckZ3M3ZXc2ozVWxZUlFLbUdMY2VvTGFYUGFkV3JxdFh5ZmphQWtjaU5u?=
 =?utf-8?Q?CLA4OYRgmbFLH9f+35oeV18=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NXpuRFhuSTdKU1FEYlp2WjdKRTBIVWg3aXZQdnNuTTdzWWN1TWFMMGt3V2hi?=
 =?utf-8?B?YUFhaWxjemQwMW5HbTJIbmN3Q3dPcTR1KytYWUpIaUhSbGwyR0NvTmJTbm9o?=
 =?utf-8?B?bkJURGJFQ0JyeGxjWWpsdUJFUlU2dFZGRzd0RTJBeGwvbURKUy93NkR6RDJ5?=
 =?utf-8?B?Ty8rdjUraC9LZjkvSm9PM0xHdEpiUlJ0a3liZEwydnV1aE5MUWhyUFVtL2N0?=
 =?utf-8?B?Z0tydWE2UG5LWjVZVGg4UHRSbjBIMjh0TzNLWGdjK1ZNKzNjemd3NTZqZCtW?=
 =?utf-8?B?WTI0b0srbG1KQ2ZBUWNJNGR0YkdYRjhhZEFVUnI3cFBXL3h6alJHWXVyVU1T?=
 =?utf-8?B?L1FQRWRURy9iU25TaEhSaVk3WjBBSW5SbmgvYStWMGJyVWVyQllVMDB3VHVO?=
 =?utf-8?B?M3ZPZE1CSm52TkRTVWVpUzA4SFVVdzFQUjA1eWdleW1qMWt1MWpvWGJsck40?=
 =?utf-8?B?TXVGVStZNzJaVDZOTkFWOCtmenFMSnFaalQ0MHBXRE54V0g3MW4rdWRoYmV2?=
 =?utf-8?B?TVVaNlhHWUQrYWdxblRuWllicnZtM05CUUNUcXNBbWoyWkdZaThRcWQ0TGVK?=
 =?utf-8?B?RE5YQ0JPZDhKT3F4Q1RUSWV1MmFGMmNIVjlyNi84dWhiRDd2SGxIQkRhdHlL?=
 =?utf-8?B?UGJxWGpTS3FsTnZjdmxVdCtMUlRhcWd3Y3NPOTRlYk5DQkRxZ0FkMytjcHh0?=
 =?utf-8?B?ZEFPait0ak82RStzeXVnTDVsMWo3ZFBKakRBd0FCUjFUTE81YzdRK3lFKzJU?=
 =?utf-8?B?a256Q0pvWG1oOXBsNldvc21qTVNwc0lqNVVhaVNpRDdSbnRrNmZkRExrUlBH?=
 =?utf-8?B?V0xOYjNIeXlKaXFBeXZibEVBNUhLTzNrSmtiNklNYVZTcUloYWRQZTlFelF3?=
 =?utf-8?B?b2I4MWRPQ2ZGNmdjQzc0SklnZXI4dC9pZmxNSG10YURvRjRlOHpqNWRVWEsw?=
 =?utf-8?B?SllIcmZjSi81b25xK21TMFREenBPMFltaktURGl5cThndTAxYWdsWWJHbGNL?=
 =?utf-8?B?bEtXS3BCb3JmUzQ2N0hsckR1dVNyaThRT0swU3ZpZG9xUlpiYUdEeStiM0g3?=
 =?utf-8?B?cThwY2xlUVFLRW5kcGJFOER0T002TlZDb2V2UzBPb2t5V2ZTUGxrZ2NUdGxy?=
 =?utf-8?B?NFVTbHROaGM0bUdrdSs4R0IveHBzbmZmL21tNkU0dnhFZUJ6MmpwT1NlMFZz?=
 =?utf-8?B?dlNidEpZZHlLeGUxZ2NEck0zZUFDTTh6Y3J6UFJEcG1vcHRPSXhxdk5TT0dO?=
 =?utf-8?B?N0pKQklKT2lVMVJzSVBKYnNnUFZPd3EwSERvdEtFa212eCs1MWVFcHVpdmJD?=
 =?utf-8?B?Smx6Y1U2cmp1RnRIQ01OeGJoQi80Wnc3ZVJIckpxa2dxZncxM3NrTFErUnFC?=
 =?utf-8?B?N2VjZElyL2hOUEtMa2lRU2dDbFFhd3E0NHQybmFsL3IzMFBweHBwUXM0dExl?=
 =?utf-8?B?T2dKWG15SHdaQklaT0JmU0ZvNmNSMDdiT20rSTRrd3huQnVrWEtIbmg1eEZF?=
 =?utf-8?B?eFpycEpLV2RFOEdYbzk2RHY4WGEvcEtNelpvbUVoWk5NL1ZGaXc3djVZZDJJ?=
 =?utf-8?B?M0o2UC9KaDNxZXAyN01vLzBtMElQaFBueDF2T2RrUmNYWlpTMjRRM0VNS2dC?=
 =?utf-8?B?eEpuaUd4NVpTNEZOWFE2MHhmbzFKVS9jT0xSZkNlbGRpTWwwU1hKWi9NNkVT?=
 =?utf-8?B?TWxYN2UvVlQ1cVZ0SXhDY3hmVE95STlCUUVSaHAwSytXZi9Cbzh6RnJ1dGox?=
 =?utf-8?Q?r5K9VGxbNBilMaqRl8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb6e046-fd8a-45f0-8baf-08db557089de
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 18:16:44.5704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qgbchfvWmscej2Ku7mbePW7RzsKEfo8UoaiPfes0ogCp8MZLzrCRIZBgM3Z6bxatFUsyLlOXbtRxvJCWSB+J25/yTCuR5ikcdaXzo/FbA8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_17,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150154
X-Proofpoint-GUID: uz4zEZuxvAEgmMLmk8pp6rE_o4jc_XGZ
X-Proofpoint-ORIG-GUID: uz4zEZuxvAEgmMLmk8pp6rE_o4jc_XGZ
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/12/23 07:40, Matthew Garrett wrote:
> On Thu, May 04, 2023 at 02:50:20PM +0000, Ross Philipson wrote:
>> If the MLE kernel is being powered off, rebooted or halted,
>> then SEXIT must be called. Note that the SEXIT GETSEC leaf
>> can only be called after a machine_shutdown() has been done on
>> these paths. The machine_shutdown() is not called on a few paths
>> like when poweroff action does not have a poweroff callback (into
>> ACPI code) or when an emergency reset is done. In these cases,
>> just the TXT registers are finalized but SEXIT is skipped.
> 
> What are the consequences of SEXIT not being called, and why is it ok to
> skip it in these circumstances?

Well the system is resetting so there are no real consequences. The 
problem on those two paths is that the APs have not been halted with a 
machine_shutdown() and that is a precondition to issuing GETSEC[SEXIT]. 
Only the BSP should be active and SEXIT must be done on it.

Thanks
Ross

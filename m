Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7536F87C0
	for <lists+linux-efi@lfdr.de>; Fri,  5 May 2023 19:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjEERiT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 May 2023 13:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjEERiS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 May 2023 13:38:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C7B44A9;
        Fri,  5 May 2023 10:38:16 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345EY2l5013299;
        Fri, 5 May 2023 17:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=r8+hdE3GD/wqfG7Reo0WJtA9eTkVZ/vv+1aUzIH56XI=;
 b=CjGw71nnoZlpy+YRlntdA1YylfvUVW8aYyvX0/B4kdJSYi7d4ZxCNCkWxdHMbIgpWZok
 rs3IDwQ6jJ4hXUueySTqnozaYuwfzWVkCsjxccv4u4eHlfCsipHoynD2MZxs1VETAKUy
 56zWxXgcw+o+Xyb6fYA7tbjJOHasEUKzcRC24KmZDn+C18XCXX4WkjcLKRA4XAB6H3oV
 s02+zjS9b2ynZOVDKS0cWIS0eAKPOR4JN7GLq54vnC3Qk4kyw1syEEAjt3KAVWrv6CV1
 3fKmOhgXZ5v3BBBcTzeG7f6SO26Vw+EmROykkcdAnxv+gtZ+BlcnWpHXiRGJnHezX30u VQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8sneddj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:37:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345HMPVZ027515;
        Fri, 5 May 2023 17:37:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spgemfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:37:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiZIbN+IkB67ymeOhhzxDIa3gt1CGBIUl91kn6lMtKJIrNDiGGeADme1+70kNA81PRNcldhsRxCk/Kdx317KNoanHr0Fr1I8sP4ZTi8vIVtSduGSnjQYxZXXYxu66Pfrbvyox8heXJGYHa1Tw/xUOHgHrCwDRpu5tw5z2uOyoq7+0o6jyof8d2pxfLV2TYQtKiVAnfgcIS7XUfZD1Jt73r2OKtdRVLieZqli0XxyfXe48mF5FUb6g4FBIcrn/xRv08r/Y/arNSyNNXrMPpamUk40P8PclCuecW6vstQiyi/sJL/BpWhrgBOZDwsqugMOnEM+AeLyTTTeeq+4pNYtdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8+hdE3GD/wqfG7Reo0WJtA9eTkVZ/vv+1aUzIH56XI=;
 b=V7Kxw6JKa2AMDMCUecj/LDbmy9I6345D27G9b0eGhDzMXsqaJRw87FttQPPLqc90YfXfOGNk1nvdjaUZm80GKQKsw1z+c6lYq//MAL5+zlGV8z6/4edjedWWTrzbxRSSO453WQGY+jtJSqY7KAYxnX8Mvw4RatjMdWgnHYNB/XmmCUideM3LAyvFeZMQRsxZGvmEbHRaSCeyaXxML6P7WR+F/Bh3yVzORLX8+bLhsWjaIOM9uVD7Kd6Pxe00hpYrj7fwKPikQBtCIqMghKPj+QZRLyvHazeAfCd5YWqD0sfffnYnSbWIVn78Vy5ecIm70m9W1s/MfE18+xOxjTwqgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8+hdE3GD/wqfG7Reo0WJtA9eTkVZ/vv+1aUzIH56XI=;
 b=ghfoQ4k02cyy3h0iJKNOtX/3Lxt5epd7VuVEfnFHVErILrFTsfHUjRHmbOshPjACHBWYM+vjXVVbdXOlnO1gMnq2ksNHAJpMg8nhl0RNsRQYdczaief6EnRZz8EhEQTVYzI20hX3mr1z0W6xWcPtqxDyWAGPeXpP1ZGIOImBHU0=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by SJ0PR10MB6301.namprd10.prod.outlook.com (2603:10b6:a03:44d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 17:37:49 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 17:37:48 +0000
Message-ID: <4c841c3a-a74b-4112-24b0-aa90ab81c46e@oracle.com>
Date:   Fri, 5 May 2023 13:37:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 05/14] x86: Secure Launch main header file
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-6-ross.philipson@oracle.com>
 <ZFUuBIh4wSnXwBnz@kernel.org>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <ZFUuBIh4wSnXwBnz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0734.namprd03.prod.outlook.com
 (2603:10b6:408:110::19) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|SJ0PR10MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: c239adb6-e878-4b3d-43a0-08db4d8f7171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGuAR/b8Az36HzseCcWPXicrD7AipXm+Hdf9KosdwfF48zYYWmfuespgsMJQR/mbxMldGHHZGHz8npgdlEDXReAc7NuqC8qHTAkA+LsiOnss+Tw/2k5WYraBlAmWs7WCoLN2yKeqjqhigWtYk8nrdBWiJ2Ktd7kWVkgt/pkD+MobIvUI16Sau8DGahAByhOx26IdmjJ/LYJ5BjsO2WlJzKhkbAuHu0EC33KN7Cr9Z5eGmI85LC/+uyIv7XWwjV1q3YENX4pywTwrjriFZoL6U8DFK6sWjmNQmLhblQPYUe+JP1d1Uc0QXlN7ogEvDG7J5OYdSSbLRGZ1H3ktXeqHeoyXaT+aOCETOB8BImQr8v4PLIbNvu7PyLJzszE8KsB0c4mGzFR45ZWCObg16LuFbAH68RLMZ1Mpe2YPqdwvyXEhZlsmVUvKPGNgHjqIMRP3LOC0SHUcUWBvKsjY5037Z3lZ1Xrraxy0G3K/jdhNsmLXXK2B7y2LWJZJtoN70Xx+GpAaJ2HeqY1b5dFtdaB+VM/0CUh+D43aX+VdVXknVQ4bfNgLHgDNc9Kh1dWneiucTpbImS+a/+rLGcNwnxaWGcqH+yZcu/4dhE//UteVOUAHtM1LsE0NcnrZAkJSHWLl047Jwr7JyoVGnBWJ9Ovw1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(31686004)(6666004)(6486002)(478600001)(66476007)(4326008)(66946007)(66556008)(316002)(36756003)(6916009)(86362001)(31696002)(53546011)(6512007)(41300700001)(6506007)(2616005)(8936002)(7416002)(2906002)(5660300002)(44832011)(186003)(8676002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnlRaFl0UkZ4RlJrWXhnNXMvUFhmSHFobW56UDRiL1JEcUVnVytqSXo5cE40?=
 =?utf-8?B?MGU1K3JKaTVsdHAyWGRKZW1GMTJaT3pjTEhONVlRbTBJekE3TFZEdG1oU2NM?=
 =?utf-8?B?c2ZIa2Q0bW1xM2tYamRJNXNxVHY0OXVtTjJ0eFBpYVhXU053MGdnN2ZROXgr?=
 =?utf-8?B?eEhkUzgwUWJ0clQ3MlU2akFVc0xWazk5RmN1WjRWWkZjaGVibVAwNDdESkRK?=
 =?utf-8?B?bHJlMmRSUUJ1ZVVTY2picjRydnBXRHRVZGFTREFuSkFDOFVmR21VWkJSc29B?=
 =?utf-8?B?Qkx3SUpFQzYwak1ZTjN5WHRnM1FwelBOUEVPQldiY3hXMTVHZnNBdmUzVDVx?=
 =?utf-8?B?OENycjcrcTN6MXl4b28xaTRxaUtQTXpjVDFnY0tIN09QZHRhbS9iL0Q2dWN3?=
 =?utf-8?B?dUJNeG5XRzJyWlBDN2tzMnRlcnV1YmRLNnN5dW8xNnk3aGZCUXJiUkYwaEhQ?=
 =?utf-8?B?eWxvOHlCcWpMN1ZwR0N5VTRLT0ZVdEpCbVU1RjJCbVpmWnk5ZW1qVGNYcUJQ?=
 =?utf-8?B?KzlHZWNnbldFYThMUFJmb1FKMlJRdENsd2htV2xiTWppcHJXYjdSb2pRQTE3?=
 =?utf-8?B?WHN5RFhJNW9SNmkvVnFEaU9jckZsaUYrUHVJSGd5Slg3MXVzUW1qR2tmQ09R?=
 =?utf-8?B?Z2ZZTVdDMkhJa0QzaW5BV2FxWE0yNzQ1ME1NWnJOMUJYaC9QMUNQRTg5U0Jk?=
 =?utf-8?B?Mm9HV1R2KzB0MjBtRGd1ei9aSkNET1lZay9nOXJxTnZZTDVRaE1YMDFPT3lh?=
 =?utf-8?B?eTAvdm5hOEIvN2VGMzBVdXd3RFlxTWQ1WHpxTGxTTkVVSnhPTUFXb2VXd1RH?=
 =?utf-8?B?UCt3ZnlzRDhGSGNWWkhBOVJaNXJlWjVXYzZtTmh5a1drcGtMM3VsRWg3SW90?=
 =?utf-8?B?aEhzbzlsc1E0NzVhamJBT09ac2pxQlRLNUVOc3dSSm96ajZmdjR3QStEMUdI?=
 =?utf-8?B?SmpZR3ZxMEF0Y1hoYkJEQzdhQ3lwclVGOXNWTTZrNWZQNUJLUUlPbzBaV2Q2?=
 =?utf-8?B?ZkNubXVkZDJ3ZytyeElLemUxWVl0empTMTJKanhYNjZsNFNUK2E4ZUV4U01E?=
 =?utf-8?B?a3ArTTNKSUZ4K3hjd1plYXlwa2VPK2wyYnIrQmlGVVBORC9VaGFBS0wwU1VP?=
 =?utf-8?B?aHdDdDl0b2N1NFZpd2V4Uks4bUFoL0k2K1hRTXZJb281bzlONGQwdEJlSExV?=
 =?utf-8?B?c2k1eEdDOHJTRVJCRnBXV3ptZi9FT01pQlZRdVZ4WmJnZzFZZzdCT2lTeGQr?=
 =?utf-8?B?enlYei9Bai9EdXQ2Rk51VktMTkxPOUYwZ041L0Y1bmhINHRYVTNEZnNzWUoz?=
 =?utf-8?B?RWVIZjNBRTc5MjE0Si9Ham9OeHlHNTRkeVJzallCelhNVENQamZzU2hMWW9H?=
 =?utf-8?B?Q3poaEIranVrTEQ2R3RJcVp0eGZTdS90U2ZrNnEzV003VFVDZTlvN2pRYjlC?=
 =?utf-8?B?ZkMyeFlmLy9yczd2QUQ1WWI4UmZJak10eTgyTUVqZ254NUNGT01mdlF5RFAy?=
 =?utf-8?B?NXR1QXhpTThnOG44L01GV01yRGNXWFErTGhzd0tlVWp2cWo0ZzJvdFRBblBU?=
 =?utf-8?B?eVI5cHJ4L0Y2akxScmRmaXFML096eTdERndQQTdTcWJhUU9USElTVmFGVVFK?=
 =?utf-8?B?Q2lwQ2NTdUthVVZHYS9PNnVMQnFXMVZLTndTUUw0RHJyMEdpT00vSWx1d2I0?=
 =?utf-8?B?SVplSnYyZ2R4SXlWV2ZFQ3VJdUhJc1lMMlBHM29tbVl5dVJrMDV4MVFUNUZ0?=
 =?utf-8?B?N2FpeFdwQUo0M3BUSUUxcnRpeGlCYXIwRFRJQzF4bVVGeTY5M1ZTNkRmMVlk?=
 =?utf-8?B?aFFybk10SXZETVhiUUdyM0t0ckZnTU0wMUIrKzhkTWptTFozbUZ2a3JJaTl5?=
 =?utf-8?B?V3JUb0lmNkhsa2lpSWhpR2wwUVlNMjNPRzNNZWpBWlVWT1BHWTd5Mm5KbU91?=
 =?utf-8?B?RGI1bTV6dzFoTVk2S0NuakxaNWtnVnh6VDQyQ2diS3Nid0NwK3U1Y2RoYTBn?=
 =?utf-8?B?K2N1TkV1anlDaEhuY0FoUFdKZ2dlb2g3NEFsbVRBQUdKZ3FlQ2pvOVZZZElE?=
 =?utf-8?B?b2ZJTHVsREM0UlNRVEhWM2hZdkxIZ1Y2WFMwVFE3dTdDVVpBdi9hcXNYZDUx?=
 =?utf-8?B?VFJLUjI2RkRNQ0ZzcUE2NGtvQ1VzZ1lPK2hpOG1Ub3BtcEFNODlNTWhQY1B1?=
 =?utf-8?Q?1iiNPwXI4LT1rmKWtS5EQT8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MkhRTGVHekJzc2Y5MHowQXlSNHdFUmZpZldyN3FQK3ZScGVVUHIwczJGWFpw?=
 =?utf-8?B?M0NRNVo3MHkvR3RtNStDMGNrNXAyOXNWNTQ2bEJKV2xna2dQbmRYQW02QSta?=
 =?utf-8?B?YkhZS20yQnFjbnBtVHlYQzlFT0R0d3l3Q2hjRHNYclpLQjhVcHNNK0lDbUV4?=
 =?utf-8?B?Z1VRSWd6TG9zUVhNdFh4QVlWZ3NKTW1pdG9KYlZlL0NFSWo0YTNWdFA4ai9p?=
 =?utf-8?B?ZU1ta3dNTG1nYURxTys4Q2RWZ3hZUmNsa3R1bGxXMWU2SXBGZWdLcXFIaXRC?=
 =?utf-8?B?UUN1cjI0TUJnb2RUU29DWG5kVDRnazQyanZ0R29tQkpYVTcwbFpqTTFHTFVM?=
 =?utf-8?B?bGcxOTU4WTNrdFNMd2lySm5pKzBiWlZJcno0UUIxMG96dWh4c1pwL09GNEJz?=
 =?utf-8?B?NzVLelplMno3Mi9yWDBGUjRWcGt0OWk5cFpZUExKcWRVaUtFaG11NzVNQmlT?=
 =?utf-8?B?cEhPanBJY3FHczBaazhSVE9DcjB4OG1OV1RGNjU2NDBSR0lOeDJUbStWUEdJ?=
 =?utf-8?B?R3V1aHBWZzg1Z29XQWU4eEZGWVJMWlpDZjJmcG9TL3hQNzRzczBLcUZXd3Rw?=
 =?utf-8?B?dnh2SXRwTjIrZjNuNWVWdnNLNThjNGlmbVpXTjAyK1dYV2phOVRuN0U2aGJH?=
 =?utf-8?B?WXFmd3VMelhGZTB3cklYaU1zU1hVR3hYZFJVYkZtUGtnZStyTXlNdElDMit5?=
 =?utf-8?B?dGc3UFR5emh6ZDNEckIvWlNIM3RoWnh2OVhUcmxERzlnYWdsck1xNnBZampn?=
 =?utf-8?B?ekFZaUdLQ2xKbENVeFRHeUdhd2tscWNMN1RBN0p4T3d0Z1hBTUxiYXF6NGxJ?=
 =?utf-8?B?SGJTQzhUeEw2dlc4NmFFNXlRcE9KR3h0bUpHRXozbWFPb1ZOUTRQVDFvVTds?=
 =?utf-8?B?S1hFUjRFUTlGR2h3c3RJakdTZkpJNDJCbFNpNE9oT1FDRDlpUFBvdnJ2RkVM?=
 =?utf-8?B?QUZkeEJVYnZPOExRbmMyeDkzbmNnQlIvL3RrTWhIU3VsWEtZT1N1V0lrTnVm?=
 =?utf-8?B?Y2o2M1JtUEx1ZFhVbWtjUUUzMEsyaEtXWm8wMUVpSGhEQWJkUTErMm9ibDln?=
 =?utf-8?B?YXdJTndVUmNXaHE4ZmUzRzBhOFJ2S2pyOU92WFROT1AvdXEyOU9jQWpCYW44?=
 =?utf-8?B?eU40SGZ6Nms0QjZwWVZDU3ZzZ2ZKVXNqOW4xK05OQnNsUVpJd2drVTJ5Y2FX?=
 =?utf-8?B?SFM0bnN3UEtXeTkrMExKY2QzMFZnWjhvQ2RybWJMZDNodDczdHlWc1pUNlU1?=
 =?utf-8?B?UitGZDYvblVGdjlnSERKSXRRcmV2ekRPY0VIQmNFOGlwcjh0S1lDOUxld1Vt?=
 =?utf-8?B?NW1yYVlWSkc0TDZqYXpUeDlETUltcDRWVTBFSmR5ZkRKSmlTc1ZGUTA5c1o1?=
 =?utf-8?B?a0Q0SkZ3MURySXJBcDBIeURMSDRKOTUxUFhqMSs2UzcxaktzaGhkTkRyMnR3?=
 =?utf-8?B?U2NDUGpldFpuNzlaVkM2YWJEOFc3WEVQT3plSVJ1TmpkYitoQmJ0WFhOU2pO?=
 =?utf-8?B?cUV0ZmxLN2dRNk5RN0F5UFZiN2pMY25MSXVoSXUwV0ZEYlJpNzRuQUtUWDVo?=
 =?utf-8?B?dEZpUUZmTDZBbHNRd2djeE5pd2dMVzcra3VZbnE5NGRNS0paVWNMOHNUdGUy?=
 =?utf-8?B?dDRGYVp6anFsT1JGTGdEdnlkMm52cndhOWFWWjdUZkdxNU1xdWZnUUc4aTAw?=
 =?utf-8?B?M3loV2drbUtkSUEySG1NZGIyaTdsMGl2cTdwVjZIbU1yK3ZuWGM0VzE3b0Nq?=
 =?utf-8?Q?Fz41XujKPBnyrnQN4Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c239adb6-e878-4b3d-43a0-08db4d8f7171
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:37:48.9726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jn2+Ub/F9Bi4UFzcdph37mK+cU3C9oU2jwWt6T+nPTX+8ZAFOZvBXJCZwEW+nE8l16E0boQfbpeOTuAcOuJCpDfUbKYLNdUVFQOCFg6ELE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050145
X-Proofpoint-GUID: CeVgy_d8EuAn1vVB8Da-ZlM3Y1WC_C9f
X-Proofpoint-ORIG-GUID: CeVgy_d8EuAn1vVB8Da-ZlM3Y1WC_C9f
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/5/23 12:25, Simon Horman wrote:
> On Thu, May 04, 2023 at 02:50:14PM +0000, Ross Philipson wrote:
>> Introduce the main Secure Launch header file used in the early SL stub
>> and the early setup code.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   include/linux/slaunch.h | 513 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 513 insertions(+)
>>   create mode 100644 include/linux/slaunch.h
>>
>> diff --git a/include/linux/slaunch.h b/include/linux/slaunch.h
> 
> ...
> 
>> +/* TXTCR_STS status bits */
>> +#define TXT_SENTER_DONE_STS		(1<<0)
>> +#define TXT_SEXIT_DONE_STS		(1<<1)
> 
> nit: Please consider using BIT()

Ack

> 
> ...
> 
>> +/*
>> + * External functions avalailable in mainline kernel.
>> + */
>> +extern void slaunch_setup_txt(void);
>> +extern u32 slaunch_get_flags(void);
>> +extern struct sl_ap_wake_info *slaunch_get_ap_wake_info(void);
>> +extern struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar);
>> +extern void __noreturn slaunch_txt_reset(void __iomem *txt,
>> +					 const char *msg, u64 error);
>> +extern void slaunch_finalize(int do_sexit);
> 
> I think that extern should be avoided.
> Perhaps these are in a header file that can be included?

Someone in an earlier review asked me to add the externs. The function 
are not in another header, they are in a C module.

> 
>> +
>> +#endif /* !__ASSEMBLY */
>> +
>> +#else
>> +
>> +#define slaunch_setup_txt()		do { } while (0)
>> +#define slaunch_get_flags()		0
>> +#define slaunch_get_dmar_table(d)	(d)
>> +#define slaunch_finalize(d)		do { } while (0)
> 
> I think it is usual to use static functions for this purpose.
> Usually they end up in header files as static inline functions.

Yea we can switch to using static functions.

Thanks
Ross

> 
>> +
>> +#endif /* !IS_ENABLED(CONFIG_SECURE_LAUNCH) */
>> +
>> +#endif /* _LINUX_SLAUNCH_H */


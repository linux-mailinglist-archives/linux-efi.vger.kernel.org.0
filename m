Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDAA6FB36E
	for <lists+linux-efi@lfdr.de>; Mon,  8 May 2023 17:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbjEHPIP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 May 2023 11:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbjEHPIO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 May 2023 11:08:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF881B6;
        Mon,  8 May 2023 08:08:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348BIhgs030652;
        Mon, 8 May 2023 15:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=LofoAiu2lmmrmefC56neeLrMFWUMWU3DfoPME6EYRKw=;
 b=owK7yBCpitTaSwGIK/8bK9OuZAmF6Hqu3QVlssWEson2tqkwhZ2mvcgzIusjri+1nVGU
 7IgfpIj0MKrBB0TQsOK9g6rAEqWVcjN4SpNAz4/JxBM5Oc6jIIG8oOOfvNECjUpSaL+W
 ZgWkL5mR/DqxSUokbEuruig59gdtV/M33mGke2qSfXpdJvrVMfglB/W6S8I/YPi++af8
 F4vVTDIrvLtaxOLSXXeGPLnmiYjuC45TWVnbRXZR+NeZy41tLfmo0+NUtLZM4p8DjRfi
 vTtLpL9zVcoQS6xPy5P91lOZU7jDnNenMMsqTQr0DHl7rfCr8plyigj01ghkG1ORSlo6 Vw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qdegubm8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 15:07:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 348DsieN023387;
        Mon, 8 May 2023 15:07:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qddb4uxem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 15:07:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlNyMZknutd5hkPxDJ7GsVK8uL5kaKA+jMJmzhjTe5kp7MXe3l5deC1iKYIHOKXuR+rJGRXrX8PUcb273jjKggxOvLEWk0yNjWQb8ldKqoR4H5DkK57xvcQQJr0txl+t93UqDuIait8krCeLDrmffxColwYKeFVGz1vRwB2jJzL90MH3GaDI2DAdTtyaTr2v+Lif3PCIreHZQPTMgi0wz5C/M8lgNBkRMQc7wrb8wZxt9wrHtwbJyQXh2DPISSyOoX0DOEarvh3mTuU8OGyG+Z5DctajLuXUnTLoRQW4Vnl2O7EHjaUfLMJOhrwB0cNk6mQPQHykuArMY4YXH12sEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LofoAiu2lmmrmefC56neeLrMFWUMWU3DfoPME6EYRKw=;
 b=FGzKM3AgCmOhCDYOdzrTktnaB3cvtGo8wco7CyoEwvvx5FBAoY+hq51oW2M9t73z3DNPBLZwNH4uKXfUjo7EldBwUv896udKOjXOcXwmTlCZhHZ/HMMyw5AimNM/9Mbo+xWsiuDe++BDkLHa/J8+QGw5b06hPvnnjMXuwXE6YmyfWy8RabxIbsegy4aKD5jUFnbLNjHKb65M6lc+RcJjYlE3UaDpXrlR9JOt7nrqVHM24J9/gTA0zmRIO2+lO5IVWBgA6Nf5EHutr4ne4kQ4Q97qp2yv6sBgu7Og7YEiLSeeG9YeXSwSENwGP5kjlXp293SfuKv4pFZxMmB1tnyKhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LofoAiu2lmmrmefC56neeLrMFWUMWU3DfoPME6EYRKw=;
 b=AKofL3USTELLBOgu4bb3sO2g4TKMYV8cGTN6HWop2w3ab2xLfTKsZala5rGaLY1drSfcyGYwYtehRvGWAtZEyjHLr0U3KGO1fQP74cl0BVM6BgM1Jg10xvFNEzsoYBIjHKVrIY6dsa7F+Jq8jSffnvG1lpc4g19/Kz0dwlWIOd4=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by DM4PR10MB6039.namprd10.prod.outlook.com (2603:10b6:8:b7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32; Mon, 8 May 2023 15:07:27 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 15:07:27 +0000
Message-ID: <305fcc15-0aec-8f9d-f98a-1e8966418543@oracle.com>
Date:   Mon, 8 May 2023 11:07:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 12/14] x86: Secure Launch late initcall platform module
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
 <20230504145023.835096-13-ross.philipson@oracle.com>
 <ZFVcEI0RAS5pvrAc@kernel.org>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <ZFVcEI0RAS5pvrAc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0047.namprd14.prod.outlook.com
 (2603:10b6:610:56::27) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|DM4PR10MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: 7acd44eb-498d-4cfd-c275-08db4fd5eeea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lfmwn+mfToQUdzrxqfLjBAXvhBC6KjIWNOiMxb54YbSjEg/LJ4SiV5Ibmrmz2Neu8XghUw/TLiCuKLjMtx8UJv1UN14Tw4A/K6giHfHzNyT2+cHpw72Kn2hTec1W+7YyyC1r+UMjYDoHUp9hRcpGSpEibiewKouAsgCG4tYxpzaaldt3v4rXf7tqSusGS4d0yuRbF7D6bxJkBCNMK2eC2QARJwnup62Umo00kmwwXpeBF0NZvSBhqI1bcW5Bztv+fnf0gLqO+qAssXhoFqSZ8GNk1MSpKhmsJGZ1YTIXxgU9kKCm6PLad0VjL3/focFLsK4QrITPkmtperyZhlmRvub7NiKshvof24Y2L8hJogfmqQDZ5Ppg/QE7Rdm/4U1YoV7fhwJq668neZxKGCD8g7KGc/15EA6ekg1tZ6LMJ4fRnOcoeGhes0VMFJr7mgbo3/74PVwNBSplkzAb3hmvkPYT1cqjMEoNuMkPAadzDHrQYWVVA/8TgNCI4m7g2MoLMgV7qmzB0060flG9t8VC2cbHKz9qLy86oeoe+7janhkLC6mA4SpoxlBNfffFTW93MQjMdf4qNJW9razsnvWBpxQu3xVjKw+WOlpCh0l9fJWq2p/2cr6xaxMlZ2XJfhA2bpxpIXLYopU6CtvYBydmyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(83380400001)(6486002)(478600001)(6666004)(2616005)(6512007)(6506007)(186003)(53546011)(44832011)(30864003)(2906002)(7416002)(38100700002)(36756003)(6916009)(66946007)(66476007)(8936002)(4326008)(41300700001)(66556008)(31696002)(8676002)(86362001)(316002)(5660300002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzNVTUk4ZzNoUk96MHV0STY5TVlGZXBuOGZxWkZ4MWUzMkNwVzhyMkZFLzQ4?=
 =?utf-8?B?ZEdZNEFzWFJQb2NlWE5FVm4wZ21PL0ZUOEtjd3BaRENOSlRJdmdxN2RDZWpi?=
 =?utf-8?B?ZU1MbVJqcUw1VXdkbUFPNGhoL05kNWtrc1RpMVh1Zlh6WWJMaGdTU2p5MVI5?=
 =?utf-8?B?SVZtMGtydjQzMUFOMWxvRExjYWpHNnBKSlBTNTlMeTFnUTdGVjZPSnZpdkdJ?=
 =?utf-8?B?MEhKQXJHQ2dEeU5ya1NRTXdlVDNOcmZPamphb3Z5Yk1SMFI1aTI2dnczSW84?=
 =?utf-8?B?L1gvUnZEUHBLUEJacy96WGxtQTV4QU1FMHNaazNhazRKMTV0N0ExMG1KTFhq?=
 =?utf-8?B?SnkzZlBLSmxJcFl5c2kvN091d1kwSDJMcGUrWmp3dlF1RlR4V3hRTDlYemRv?=
 =?utf-8?B?aXBiQWZLU2VWK3JoZEZLYjhWQy9ncmV1WDRGeW9BWjJRaHF6aEs1ank2NnJH?=
 =?utf-8?B?d1VuVUdZSjZoNmt2SWlKZWpmYWpHdng1T01VTE1wTlU2OFRTNjF0cGkxRCs3?=
 =?utf-8?B?OVNJZXNIcGFTOFYxWDhOYVJJZDg0THo1b2ZmVHVLWFVPeG45OXRqSHZHMTlL?=
 =?utf-8?B?SENoVWJxOHdpMDRKcHpXaUk5MmRqNHAwVXlXcHM4WWNpbm5yck13RjhMMmV6?=
 =?utf-8?B?VFplb2FrSDRKaS9admVxNDRac011MllGSVpEVG8yV2V5U2dYd3E0Skx3MTN5?=
 =?utf-8?B?UXhyaHBTQW5DcmZmMXpkOEdaYksydWtlVjM4emlidFhMaEU0bHVNYTRwSTVy?=
 =?utf-8?B?cDhhdnBFb0NkNWVXRUl3aFBEam44dlZGalo1aWtlVUZHdHBkZkNXUEUrejF3?=
 =?utf-8?B?YkN5QUFqdW1xVUZvK015Uy8wdTAwTVRZNE5RMTcvSkY3MzRLSHlKUXNPTVBH?=
 =?utf-8?B?NFEydC9tWDNnakNnZmVlUi9CU3dCcHJ4eU5YSHJ1UVVHNnhqVlJ3a2NYZ3Iz?=
 =?utf-8?B?d0ZsditWZURjMlRGU21RNVdYaDhPYlNLQWh2NUpGclUrQUJFbk9KWWRWVWkr?=
 =?utf-8?B?UTBsWXgwckVJd3NPRTc0RFMvbm5lcXNBdnMvSUt6bDlKVk1SV0t3SC9zYkRN?=
 =?utf-8?B?TDZWYWJzeTcveVlFbkNVS04yd2l0MEJHMmI2RmtaM3RTUml1aFRob3lzdkx6?=
 =?utf-8?B?NXd1eFBmVXhlUlQyVUFEWU1TOTVuRmpLUUpmeENJenFvcmVjT1RIVXowM1BI?=
 =?utf-8?B?UGlseVA1UC9ZM0JlYTE5R0U2OHhTM1IwNUdjRjhRODZsU2RwNjdtRFJ5Nm5q?=
 =?utf-8?B?cmdycFBaU1crNEVXVW1FaEJNSHBmK2Y5ZmJURXZpNklUK3RDdFNwc05NaVBN?=
 =?utf-8?B?WEZUeGdTOXJqL1RwN25ScXVLQlROZFZ2K3Nia1hoaE8rekhFb0RzMmlvOFhJ?=
 =?utf-8?B?cmMxNU52QTZDNjRqNk9IaGd2T0o1ODZQdjhjc21VVkZHdTJxMU1KSmxTRk9r?=
 =?utf-8?B?OUlZYktGVVhVcUV4dkZPNUNPT1VaVEkxUTlZQkk5UGhCK2NLRktPUXp2SWht?=
 =?utf-8?B?ZFNBalA3MkpaTGREREQrYzRxR1NmQm4rbHlFK2pXUElKWTR3VC96UldxTCtl?=
 =?utf-8?B?Y1I0bnRNUG4rTVlJZ2tsS2QrV1RJaVYrbDRlcHdqNEJGMS94S3NudmlveGFU?=
 =?utf-8?B?YjJndGJtUnVVNisxbXIzR0pOVlNyK1cxQnpNRVJ3Z1hjUEVFSCtEeUpDdGxS?=
 =?utf-8?B?V25MM09OcFpEb0Z1NTk5N1ZuUUp3R0c2d3Q2OTJXTExTK0ZzakUxUkVFMXRB?=
 =?utf-8?B?aFFzb3ozdFQ0NjNIWVcrWk0vTU1KTUczM1BZeTduS1BvRU9mRHlGdkx3b2tC?=
 =?utf-8?B?MVNRcW5EcFU0dHFyWEdvUG9zZUp3TVMxcnVqZEI0ZXpHMFljZ0MzUTNVVk5M?=
 =?utf-8?B?OEYwb2lKVUQrUHd4STM4cFVhdWxpdUV0b1BoeXVyN3RGaFgybmkzcWxWOU1w?=
 =?utf-8?B?MGQ1ZHFKNEdwY0pkN2VZNy81VWdMdUZpak14ZlNMMlpWT2gyTEFIN2o3U1Zu?=
 =?utf-8?B?RGR6cURORnY4KzR5dVJGT0RNNGZzTEdsOHYydWxJSzJlL0oyYXhGWmdkVzd4?=
 =?utf-8?B?NzhwZFJmc0VPN1lUU1RCWlNMT1hqaERQTFN1NldRNlJ2SXZVUUxCQ0p6RzBn?=
 =?utf-8?B?c094NTk4Z0M4djBGZ3FKMXNzWjB0cjhuVHNWMTZZS0c3eUdLcDRQS1hRVTkr?=
 =?utf-8?Q?+GsAOXPgUaVVYUYf5CRipBg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YUlBUHZNVFlEbWdIT1JoVE9GRXdBS09GaDFmejBPWmVLVmExNHZFZEhkTjFR?=
 =?utf-8?B?K0hkY09pWnZja21Kc3dRbW85cVowMmNHZW5DdWxZcUd2bTg0NmtqWmdnbE9I?=
 =?utf-8?B?c21XWFVHaUxnNkZ3cU90SUdXUzZERTZ6ZndsVFFHaWFVU1dCS0pmcHFnYlBW?=
 =?utf-8?B?WGNhZlFjZktnNDR6SnR3aVNPWWdpUitVUTNNaTNGSHhNMVFFVVQ5WlArLzVh?=
 =?utf-8?B?eThtU0JtdDVsWkRVZ29SMGcwZ0ZkVFQ5czNuRDJnL1ErVzNwUUlYN2Y0ZWND?=
 =?utf-8?B?b1lCYit3MmovUVRwZDNNTWI0NkJTZ21YT0VwQjRmRXZkQVJaU0pvUzFKR2Jw?=
 =?utf-8?B?eVZ3cSt3dVlDUW11cGVVMnd1cnlTbTBIMUMzYVVRcjJMSTY1SFIwa2FDamdp?=
 =?utf-8?B?aEw5SXI3dDdQZFhTTmRCYTZPS1pjM2lzMGxhY3VJM3ZsOWc4aHJtbHRZTkRL?=
 =?utf-8?B?MlNRZmhWc05LT1g4V2pQWEJ3MVh4aVp1amNMNHBYdzQ0VkwwUVpTNnFUUVpM?=
 =?utf-8?B?ZU1nYktQY0VFNVEySGNHQkVqS3lDbTBvTTlLT2ZhNExKMTQzZnkrT2VYclY2?=
 =?utf-8?B?V3RBQ0tSOFQyV2FxYXYrZDNZdnJ5WlpiWDYxRXZnWVBGSkN4WEtucld6S1Av?=
 =?utf-8?B?K0l3RnNJYzJUVThWQzJwVHhFQ0d5b2JOV0VpUUJNNUNVM3Y5YStLT1ZuZlZ2?=
 =?utf-8?B?Wm5JT0h1MDdZWUVFRlBtb1FLMERGaVk3dzd1OGhPNzNWdGxqb1hGKzdtM2Nr?=
 =?utf-8?B?QUJPUkpNT09xTlN5OGVMbEtCbHhuMkZTRDBVeStiL3dWZFFUZEZsQUhrRzBK?=
 =?utf-8?B?QU1HNlNPczZNZHJTU0RHUEc4bDFSYTVZNHI4QmRseHpvMHFGNWRuNTQvM2RO?=
 =?utf-8?B?UjFjNjlWR3V3ZlhCTVBaSHpPTzl4Znp3KzRCalZjM2p6em83YXNHY01OOS96?=
 =?utf-8?B?dTdlL0t3Yjh1ekxxMTBtb29qSnRDUlc0dUw1ckxBaE1OUUJTRU5NRkVyZXFD?=
 =?utf-8?B?SVVHOE9kdmptMitFRWVuSnhLengyT001MXNRRzdTVEcvVjhoU05CaXJteU4v?=
 =?utf-8?B?ZXpERXB1SmRyNTZlNGUvSzBLRU5xNlFTYURjVG9uQkFtaGFIeVJVVmlNcktm?=
 =?utf-8?B?Q3l2Njh4SUwrRHNTNktWZEJXeld0T3daMEh3cnBCY2lObkZ0SnB6NVlXZDlL?=
 =?utf-8?B?V1FlY1ZzL0xLY0REaDA3RFM0bmVhY2J1ZnlQMVNWbXNEME1LMUNUTVdEWHVu?=
 =?utf-8?B?eCt6ZDA5RUhBVmR6SHlZUkJadEYyYS9GWGU1YUUrT0s2WWpQL2dXS2V5ZlBz?=
 =?utf-8?B?Z21BUVB0M00vUzJPbERiMXpqSHpBZGViR2svbnZCdzBpclhQZ3FscDV5RjZO?=
 =?utf-8?B?STJrc2JtR2V0YUU3WnlWb1hnMEVyQjkvSHNvNy9xYVJ6QUZicU1IekZDQWYv?=
 =?utf-8?B?Y3pjNlN0NHpyanVtUm82V0h6VXI5QUo3SUY1UC9PMmQwclJ6VGRLMVJtSVU5?=
 =?utf-8?B?Q2t2OHZSTm9nMFZHZVFFMXV5NUlKMlZHcFB2NVY5UkExWE95WFJxQ1VVYSs0?=
 =?utf-8?B?TDNCUVYrK0V0YUdabDhqTnBXQWVXSHJjalF1NGtSZjVPdTE0QVM0WlpUWVJl?=
 =?utf-8?B?NHlwSm8zV20xTjM3bDJQbG5ROUIwVm0xVkdOY3FDMzc1b0NOT21oRFo3MjNZ?=
 =?utf-8?B?bWdYOGhxQXZsMXhWeDRoSUlGcW0ydGg4aE5lY3pRVFROTFh6U3NpWVpkc3hG?=
 =?utf-8?Q?jjD5g2rnPTztf6/yu0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acd44eb-498d-4cfd-c275-08db4fd5eeea
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 15:07:27.0654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iH+h3VyfyvXsXlCLHwb3jz1NEHN3ryZGaU8rx83c37Eedqq4TgM4SIP3HZp/+Ogp3eoreJMTJaQ4e3dTsAhkvbuAuWUZxDJt8SRaB3/5wYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305080099
X-Proofpoint-GUID: 1P33aFUkMhhIRxDkUW0ynbwtkIfaf6xY
X-Proofpoint-ORIG-GUID: 1P33aFUkMhhIRxDkUW0ynbwtkIfaf6xY
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/5/23 15:42, Simon Horman wrote:
> On Thu, May 04, 2023 at 02:50:21PM +0000, Ross Philipson wrote:
>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>>
>> The Secure Launch platform module is a late init module. During the
>> init call, the TPM event log is read and measurements taken in the
>> early boot stub code are located. These measurements are extended
>> into the TPM PCRs using the mainline TPM kernel driver.
>>
>> The platform module also registers the securityfs nodes to allow
>> access to TXT register fields on Intel along with the fetching of
>> and writing events to the late launch TPM log.
>>
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: garnetgrimm <grimmg@ainfosec.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> 
> Hi Ross,
> 
> a few more items from my side.
> 
> ...
> 
>> diff --git a/arch/x86/kernel/slmodule.c b/arch/x86/kernel/slmodule.c
> 
> ...
> 
>> +/*
>> + * Securityfs exposure
>> + */
>> +struct memfile {
>> +	char *name;
>> +	void *addr;
>> +	size_t size;
>> +};
>> +
>> +static struct memfile sl_evtlog = {"eventlog", 0, 0};
> 
> I don't think the 0 fields are necessary above, memset will zero
> any fields not explicitly set. But if you want to go that way, then
> I think the first one should be NULL, as the addr field is a pointer.
> 
>> +static void *txt_heap;
>> +static struct txt_heap_event_log_pointer2_1_element __iomem *evtlog20;
>> +static DEFINE_MUTEX(sl_evt_log_mutex);
> 
>> +static ssize_t sl_evtlog_read(struct file *file, char __user *buf,
>> +			      size_t count, loff_t *pos)
>> +{
>> +	ssize_t size;
>> +
>> +	if (!sl_evtlog.addr)
>> +		return 0;
>> +
>> +	mutex_lock(&sl_evt_log_mutex);
>> +	size = simple_read_from_buffer(buf, count, pos, sl_evtlog.addr,
>> +				       sl_evtlog.size);
>> +	mutex_unlock(&sl_evt_log_mutex);
>> +
>> +	return size;
>> +}
>> +
>> +static ssize_t sl_evtlog_write(struct file *file, const char __user *buf,
>> +				size_t datalen, loff_t *ppos)
> 
> nit: the line above doesn't align to the '(' on the line before that.
> 
>> +{
>> +	ssize_t result;
>> +	char *data;
>> +
>> +	if (!sl_evtlog.addr)
>> +		return 0;
>> +
>> +	/* No partial writes. */
>> +	result = -EINVAL;
>> +	if (*ppos != 0)
>> +		goto out;
>> +
>> +	data = memdup_user(buf, datalen);
>> +	if (IS_ERR(data)) {
>> +		result = PTR_ERR(data);
>> +		goto out;
>> +	}
>> +
>> +	mutex_lock(&sl_evt_log_mutex);
>> +	if (evtlog20)
>> +		result = tpm20_log_event(evtlog20, sl_evtlog.addr,
>> +					 sl_evtlog.size, datalen, data);
> 
> Sparse says that the type of the first argument of tmp20_log_event is:
> 
> 	struct txt_heap_event_log_pointer2_1_element *
> 
> However, the type of evtlog20 is:
> 
> 	struct txt_heap_event_log_pointer2_1_element __iomem *

I have to look into what is going on here. The TXT heap is just a memory 
range not IO space. I will track this down.

As to all the rest of your comments here, I will fix them.

Thanks
Ross

> 
>> +	else
>> +		result = tpm12_log_event(sl_evtlog.addr, sl_evtlog.size,
>> +					 datalen, data);
>> +	mutex_unlock(&sl_evt_log_mutex);
>> +
>> +	kfree(data);
>> +out:
>> +	return result;
>> +}
> 
> ...
> 
>> +static long slaunch_expose_securityfs(void)
>> +{
>> +	long ret = 0;
>> +	int i;
>> +
>> +	slaunch_dir = securityfs_create_dir("slaunch", NULL);
>> +	if (IS_ERR(slaunch_dir))
>> +		return PTR_ERR(slaunch_dir);
>> +
>> +	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
>> +		txt_dir = securityfs_create_dir("txt", slaunch_dir);
>> +		if (IS_ERR(txt_dir)) {
>> +			ret = PTR_ERR(txt_dir);
>> +			goto remove_slaunch;
>> +		}
>> +
>> +		for (i = 0; i < ARRAY_SIZE(sl_txt_files); i++) {
>> +			txt_entries[i] = securityfs_create_file(
>> +						sl_txt_files[i].name, 0440,
>> +						txt_dir, NULL,
>> +						sl_txt_files[i].fops);
>> +			if (IS_ERR(txt_entries[i])) {
>> +				ret = PTR_ERR(txt_entries[i]);
>> +				goto remove_files;
>> +			}
>> +		}
>> +
> 
> nit: no blank line here.
> 
>> +	}
>> +
>> +	if (sl_evtlog.addr > 0) {
> 
> addr is a pointer. So perhaps:
> 
> 	if (sl_evtlog.addr) {
> 
>> +		event_file = securityfs_create_file(
>> +					sl_evtlog.name, 0440,
>> +					slaunch_dir, NULL,
>> +					&sl_evtlog_ops);
>> +		if (IS_ERR(event_file)) {
>> +			ret = PTR_ERR(event_file);
>> +			goto remove_files;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +
>> +remove_files:
>> +	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
>> +		while (--i >= 0)
>> +			securityfs_remove(txt_entries[i]);
>> +		securityfs_remove(txt_dir);
>> +	}
>> +remove_slaunch:
>> +	securityfs_remove(slaunch_dir);
>> +
>> +	return ret;
>> +}
> 
> ...
> 
>> +static void slaunch_intel_evtlog(void __iomem *txt)
>> +{
>> +	struct slr_entry_log_info *log_info;
>> +	struct txt_os_mle_data *params;
>> +	struct slr_table *slrt;
>> +	void *os_sinit_data;
>> +	u64 base, size;
>> +
>> +	memcpy_fromio(&base, txt + TXT_CR_HEAP_BASE, sizeof(base));
>> +	memcpy_fromio(&size, txt + TXT_CR_HEAP_SIZE, sizeof(size));
>> +
>> +	/* now map TXT heap */
>> +	txt_heap = memremap(base, size, MEMREMAP_WB);
>> +	if (!txt_heap)
>> +		slaunch_txt_reset(txt,
>> +			"Error failed to memremap TXT heap\n",
>> +			SL_ERROR_HEAP_MAP);
> 
> nit: These lines are not aligned to the opening '('
> 
>> +
>> +	params = (struct txt_os_mle_data *)txt_os_mle_data_start(txt_heap);
>> +
>> +	/* Get the SLRT and remap it */
>> +	slrt = memremap(params->slrt, sizeof(*slrt), MEMREMAP_WB);
>> +	if (!slrt)
>> +		slaunch_txt_reset(txt,
>> +			"Error failed to memremap SLR Table\n",
>> +			SL_ERROR_SLRT_MAP);
>> +	size = slrt->size;
>> +	memunmap(slrt);
>> +
>> +	slrt = memremap(params->slrt, size, MEMREMAP_WB);
>> +	if (!slrt)
>> +		slaunch_txt_reset(txt,
>> +			"Error failed to memremap SLR Table\n",
>> +			SL_ERROR_SLRT_MAP);
>> +
>> +	log_info = (struct slr_entry_log_info *)
>> +			slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_LOG_INFO);
>> +	if (!log_info)
>> +		slaunch_txt_reset(txt,
>> +			"Error failed to memremap SLR Table\n",
>> +			SL_ERROR_SLRT_MISSING_ENTRY);
>> +
>> +	sl_evtlog.size = log_info->size;
>> +	sl_evtlog.addr = memremap(log_info->addr, log_info->size,
>> +				  MEMREMAP_WB);
>> +	if (!sl_evtlog.addr)
>> +		slaunch_txt_reset(txt,
>> +			"Error failed to memremap TPM event log\n",
>> +			SL_ERROR_EVENTLOG_MAP);
>> +
>> +	memunmap(slrt);
>> +
>> +	/* Determine if this is TPM 1.2 or 2.0 event log */
>> +	if (memcmp(sl_evtlog.addr + sizeof(struct tcg_pcr_event),
>> +		    TCG_SPECID_SIG, sizeof(TCG_SPECID_SIG)))
>> +		return; /* looks like it is not 2.0 */
>> +
>> +	/* For TPM 2.0 logs, the extended heap element must be located */
>> +	os_sinit_data = txt_os_sinit_data_start(txt_heap);
>> +
> 
> The return type of tmp20_find_lot2_1_element() is:
> 
> 	struct txt_heap_event_log_pointer2_1_element *
> 
> However, the type of evtlog20 is:
> 
> 	struct txt_heap_event_log_pointer2_1_element __iomem *
> 
>> +	evtlog20 = tpm20_find_log2_1_element(os_sinit_data);
>> +
>> +	/*
>> +	 * If this fails, things are in really bad shape. Any attempt to write
>> +	 * events to the log will fail.
>> +	 */
>> +	if (!evtlog20)
>> +		slaunch_txt_reset(txt,
>> +			"Error failed to find TPM20 event log element\n",
>> +			SL_ERROR_TPM_INVALID_LOG20);
>> +}
>> +
>> +static void slaunch_tpm20_extend_event(struct tpm_chip *tpm, void __iomem *txt,
>> +				       struct tcg_pcr_event2_head *event)
>> +{
>> +	u16 *alg_id_field = (u16 *)((u8 *)event +
>> +				    sizeof(struct tcg_pcr_event2_head));
>> +	struct tpm_digest *digests;
>> +	u8 *dptr;
>> +	int ret;
>> +	u32 i, j;
>> +
>> +	digests = kcalloc(tpm->nr_allocated_banks, sizeof(*digests),
>> +			  GFP_KERNEL);
>> +	if (!digests)
>> +		slaunch_txt_reset(txt,
>> +			"Failed to allocate array of digests\n",
>> +			SL_ERROR_GENERIC);
>> +
>> +	for (i = 0; i < tpm->nr_allocated_banks; i++)
>> +		digests[i].alg_id = tpm->allocated_banks[i].alg_id;
>> +
>> +
> 
> nit: one blank line is enough.
> 
>> +	/* Early SL code ensured there was a max count of 2 digests */
>> +	for (i = 0; i < event->count; i++) {
>> +		dptr = (u8 *)alg_id_field + sizeof(u16);
>> +
>> +		for (j = 0; j < tpm->nr_allocated_banks; j++) {
>> +			if (digests[j].alg_id != *alg_id_field)
>> +				continue;
>> +
>> +			switch (digests[j].alg_id) {
>> +			case TPM_ALG_SHA256:
>> +				memcpy(&digests[j].digest[0], dptr,
>> +				       SHA256_DIGEST_SIZE);
>> +				alg_id_field = (u16 *)((u8 *)alg_id_field +
>> +					SHA256_DIGEST_SIZE + sizeof(u16));
>> +				break;
>> +			case TPM_ALG_SHA1:
>> +				memcpy(&digests[j].digest[0], dptr,
>> +				       SHA1_DIGEST_SIZE);
>> +				alg_id_field = (u16 *)((u8 *)alg_id_field +
>> +					SHA1_DIGEST_SIZE + sizeof(u16));
>> +			default:
>> +				break;
>> +			}
>> +		}
>> +	}
>> +
>> +	ret = tpm_pcr_extend(tpm, event->pcr_idx, digests);
>> +	if (ret) {
>> +		pr_err("Error extending TPM20 PCR, result: %d\n", ret);
>> +		slaunch_txt_reset(txt,
>> +			"Failed to extend TPM20 PCR\n",
>> +			SL_ERROR_TPM_EXTEND);
>> +	}
>> +
>> +	kfree(digests);
>> +}
>> +
>> +static void slaunch_tpm20_extend(struct tpm_chip *tpm, void __iomem *txt)
>> +{
>> +	struct tcg_pcr_event *event_header;
>> +	struct tcg_pcr_event2_head *event;
>> +	int start = 0, end = 0, size;
>> +
>> +	event_header = (struct tcg_pcr_event *)(sl_evtlog.addr +
>> +						evtlog20->first_record_offset);
> 
> Sparse says that evtlog20 shouldn't be dereferenced because it
> has a __iomem attribute.
> 
>> +
>> +	/* Skip first TPM 1.2 event to get to first TPM 2.0 event */
>> +	event = (struct tcg_pcr_event2_head *)((u8 *)event_header +
>> +						sizeof(struct tcg_pcr_event) +
>> +						event_header->event_size);
>> +
>> +	while ((void  *)event < sl_evtlog.addr + evtlog20->next_record_offset) {
> 
> Ditto.
> 
>> +		size = __calc_tpm2_event_size(event, event_header, false);
>> +		if (!size)
>> +			slaunch_txt_reset(txt,
>> +				"TPM20 invalid event in event log\n",
>> +				SL_ERROR_TPM_INVALID_EVENT);
>> +
>> +		/*
>> +		 * Marker events indicate where the Secure Launch early stub
>> +		 * started and ended adding post launch events.
>> +		 */
>> +		if (event->event_type == TXT_EVTYPE_SLAUNCH_END) {
>> +			end = 1;
>> +			break;
>> +		} else if (event->event_type == TXT_EVTYPE_SLAUNCH_START) {
>> +			start = 1;
>> +			goto next;
>> +		}
>> +
>> +		if (start)
>> +			slaunch_tpm20_extend_event(tpm, txt, event);
>> +
>> +next:
>> +		event = (struct tcg_pcr_event2_head *)((u8 *)event + size);
>> +	}
>> +
>> +	if (!start || !end)
>> +		slaunch_txt_reset(txt,
>> +			"Missing start or end events for extending TPM20 PCRs\n",
>> +			SL_ERROR_TPM_EXTEND);
>> +}
> 
> ...
> 
>> +static void slaunch_pcr_extend(void __iomem *txt)
>> +{
>> +	struct tpm_chip *tpm;
>> +
>> +	tpm = tpm_default_chip();
>> +	if (!tpm)
>> +		slaunch_txt_reset(txt,
>> +			"Could not get default TPM chip\n",
>> +			SL_ERROR_TPM_INIT);
>> +	if (evtlog20)
>> +		slaunch_tpm20_extend(tpm, txt);
>> +	else
>> +		slaunch_tpm12_extend(tpm, txt);
>> +}
>> +
>> +static int __init slaunch_module_init(void)
>> +{
>> +	void __iomem *txt;
>> +
>> +	/* Check to see if Secure Launch happened */
>> +	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) !=
>> +	    (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT))
> 
> nit: spaces around '|'
>       Likewise elsewhere in this patch.
> 
> 
>> +		return 0;
>> +
>> +	txt = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
>> +		      PAGE_SIZE);
>> +	if (!txt)
>> +		panic("Error ioremap of TXT priv registers\n");
>> +
>> +	/* Only Intel TXT is supported at this point */
>> +	slaunch_intel_evtlog(txt);
>> +
>> +	slaunch_pcr_extend(txt);
>> +
>> +	iounmap(txt);
>> +
>> +	return slaunch_expose_securityfs();
>> +}
> 
> ...


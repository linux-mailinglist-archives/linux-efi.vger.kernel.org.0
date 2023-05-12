Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046B1700CA2
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 18:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241881AbjELQKu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 May 2023 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjELQKt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 May 2023 12:10:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023C230C7;
        Fri, 12 May 2023 09:10:46 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF48K6010115;
        Fri, 12 May 2023 16:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7k3CQPvvEDGC6MlNKFh2f4kEFdRvRGKsv6wX2b/6bnE=;
 b=SQnayg1bEcXAm5AO/3NS628aqRAZCnO/E3G2UbJLccAaINE6bKb5uwOS5WUyDS4n8QCD
 qOkQ0KoUEudXryCDO0mwmi74H/yUyaath5ZUwMqALYdzBHrRfINU/wCkfglMCcW2Rq/g
 QtG3tWuMqzXBU2GBrzuavY6vPSePp9t35q4gI0yQ4B7pogOtiHeu/FYBydQFxyx/kJCQ
 rV5pYd+DYaEqRmNWS5pymx5z7ey28VYwxyDkCjPxealSj2snnny3teFJmWj8uC7JBV0O
 fGVYIUeUhm0JUOEJgvbMsm87JJceLFS5XAtoswSuZ/mSA+tlMGQTwuF6avQhJc/An0fK 3A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf776ttxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 16:10:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CFmSKs018251;
        Fri, 12 May 2023 16:10:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf77mdtk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 16:10:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1fIF0iEvX3lHHoxVmiPx2Vl2DWLDpeeztJHZT92w6GKzO/Uk+Xxx0E88cMaXbEQXzlzlzAZ7/q9dUGPCeXZ9o1kDQmLaE50Uz/+DEc5eSAAFh871NwfuyQcg7yv/m+o0fyGRmgZucdFmNvHol1oDUii9Vdk6sUwizPKW9038GYdgUlSUIQxiGj7JdpLhByvFe4v5sXq/pXDowUJfE81ewiRRI9nW+us/learMDPRI6pfq93GwC94X5Tevxf0zCh4BSLYonFrwq0jPK3kgAvKndgWSNQ8xOmSUkRnlTePf1IaL16HWVY5EKlZoTUXDxQ1Lau1bt/05RPJXKWo35J+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7k3CQPvvEDGC6MlNKFh2f4kEFdRvRGKsv6wX2b/6bnE=;
 b=Q5hAH1UsX/HSbguiInkKzL8VUHkkt0i10TS8khUDqQdV7U+Vacy9KdeuD4PeMKPCjuy3QCMM7C7M+s0oPT77vWB+B0vMLVCDto1Vu/DFFdfjlENHdXwcPKCQBriQopjqOQFTylbeP9fmM+2tpjjdqOd8RsYuF/RjFKvGSM/bR3fI3IiJAoHAKVOPlSRWzZ1v15JQ3bWsMkPWuky1WTZBHKnSvJQ84OyNL7In4DiAzQPr2SuCVfShjoLgaTGk4RkPIs8CHwgFxxUUPKPyB/8Wa3evsPB1Re/MG1dXkOdUaljG7kPZelhRzlRGHqQXSxwoNxR8OJ5GxhhKExXQ37uYSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7k3CQPvvEDGC6MlNKFh2f4kEFdRvRGKsv6wX2b/6bnE=;
 b=DCg6sKTOeUwSyoS0JOP+NsdFyZVtw/RSH5pRjHDvy8ZtZUcTDEBCAwnRu6aWgVqjUUOf9nIk+u4p8uG3WG9v06orIrkA2xulsneRhoEtTaoT5ivr/q6oS+Wr05KAmICPycCGKwPmry+Ib7GZ+EB6W95hBZrxYOGTr2DRR3g8Bbc=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Fri, 12 May
 2023 16:10:24 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37d1:ec08:a280:1d91]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37d1:ec08:a280:1d91%4]) with mapi id 15.20.6387.024; Fri, 12 May 2023
 16:10:24 +0000
Message-ID: <2f7689e0-b79a-c642-815f-a487c1b9e700@oracle.com>
Date:   Fri, 12 May 2023 12:10:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 05/14] x86: Secure Launch main header file
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
        trenchboot-devel@googlegroups.com,
        Ross Philipson <ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-6-ross.philipson@oracle.com>
 <20230512110003.GC14461@srcf.ucam.org>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <20230512110003.GC14461@srcf.ucam.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:610:76::15) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 73bdc13f-6ab8-4e95-ff6d-08db530364d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 731PhbSa+XpLdaDdHghr90ZksUp8u2ow0B4WBn9PMVz7c//LRUBeXS6zcftjSZmpU8Ra6RuEuGb2IiroX6R7vZWtPJ2DWq1twb5zn0zHo1yJNUVIOK4LoSfLm5B2pGon6OSbarDoP7YKDMPrlB4NM7lsWRuZayh1QdWn7xO52ph/KCq/Lf8y3ZlEhNZAlciwT0+SeUwSpyQngaP0kROCAwd3SZYcVka+3vZAwEBu0ZsP7uzxt+gRSiqLDg09Z1XWpVFhLhMKpUJshc2A+FsGGLdgoc5CdaIdkH8/mj0oTNrwKFRSRLjWdZbQMCzpSzxMCXdJ6TrJkDlQ8I9BnEPaDMsVQCR/RHosQf/VXczBnZ+JaqUhkne/SviELOMUj85vls5X7JFtHC4VaPv1P4k9YFHav7m2XS++kO2efkUUT04zCFOnP6rMA7FF9M0BWBREpp+UtCzgfnSEc2PFEmPMTSgXP2GBLWRWxB/pgJD0/uL1KkRQUYvn0TvuBqu8mGb05FZPYvQssIprF8Cp4BZXYymz0c/Ml64FTiXEBiMvhgyxcVqLTFl9Gh0Cepo6H3fZi7YXGsKxl34JXLhaChmH+7C0gWSPDhqOGV0H+dE2S0RYW/1gj6sIXQoVNNxg9cCRp/36LJEGf2yq95oO9TN/0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(86362001)(31686004)(31696002)(478600001)(83380400001)(316002)(6916009)(41300700001)(66946007)(66556008)(6666004)(4326008)(36756003)(66476007)(6486002)(8936002)(8676002)(7416002)(38100700002)(5660300002)(107886003)(44832011)(6506007)(186003)(6512007)(53546011)(2906002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHViOE1ETmozN3kwRmNNamFqWDBVcnVTMVZJUVd6U2tHWTIxSUk1M3ZXR3F1?=
 =?utf-8?B?NDRWT2ljQWl6ZW9aNERaQitkd2Q0d2ZaOFh6N3lGRHFqeUlXalhadGRGRll1?=
 =?utf-8?B?U1UwK2ZUSU5DaWJkVVdwTTJ4MkRnT0tSQzBSQWdnWmJZK0RZUVJsekpZRVRD?=
 =?utf-8?B?U1NiNVJ5YUhsSlp6VURhQ0FxeDZpV0lIait0blc5MGNBR3RXL0Q0TUlmNUZP?=
 =?utf-8?B?ajRDbTRhTkJUT0dPb1lFd0xQYVkyMDRJSXUxelkwMkgzeWlMbmM1K3BBQVVZ?=
 =?utf-8?B?di9NRXF3NTZiRUlPNi9CK3VYeE9TQ3JsZnZpSG9yMGtyU1ZwclpiOElCNHlX?=
 =?utf-8?B?dWVNMjA2VDlTaWJoYjU0amtoVFZxTitkeURIcWpRbGdRQjgxY3R2dkRSbU5S?=
 =?utf-8?B?bXFEQitWRzAvZU1WVmhHbDFnOVNBNnBUd28yNk5CVG9qWkg5MTBoaUFibGw1?=
 =?utf-8?B?cWNWdzZtRUsvSW1BMmNlaFc3VmxFQzdZL1liWUhldlNuNENXaHVBYWZBcTBm?=
 =?utf-8?B?UXNOYS8rOUp5aytTYmp0UHltbXB2ZHdLU0JLUkxUT3JVTVQ5a3RjVWlTeTgy?=
 =?utf-8?B?b3ZFMEh1dnZ2WTBEdWxKdFc3Z0VKZmV2bmg0eVMxSzdUMW1IUitidU8rUm5K?=
 =?utf-8?B?WGxjMmZCNmlxSTd2ZEpSQjZ5VDVjb1Y5ejlkSnpMbjI3NFRBTkxyY2VIWkNu?=
 =?utf-8?B?WUNoaHl0YWNoKzE0MVNqaVlHN3VPR1VlbFl0WklBQSthV00rMUMzRG9sWXRM?=
 =?utf-8?B?ZkN3WlJzOVJLdkdaTTdmT2ZRZE9NT0QzblRqTFNyM2hVUWFtSGMySmhmb3hn?=
 =?utf-8?B?Mm9hUVQzeGhBQ2ljWGViWXJTWk5Eejg0cldBbTI3S1pwb09tVEEzN0FXdWNF?=
 =?utf-8?B?RUp2MTN2U0JHVEN6S0ZPMDUwV0dLK1NtaWRlRDYycnlqSC9YYVNhektIOE5i?=
 =?utf-8?B?U0lWRDg3WGYyRGFod3h1VnRaeHJWcUhVenpTOXQrUDh6ZDk2bXkrazlwVElB?=
 =?utf-8?B?SnRaeCt0TU1jTVIxZ0RnSzVZZDlyZURRSWlTMEpBRFNpSllSU21MaHFyN0xR?=
 =?utf-8?B?N1ZHMXJUQnFEVXpjSkxDZ2tGcVYxS3E5TWRhenQwNGtuUFkweHhJZkNxdkhh?=
 =?utf-8?B?K0RxSEdLbFVPSGkvN2I2Y0VjZXN2NVRBb3JBdzYzNXYrblM1VlkwS1BmeTc2?=
 =?utf-8?B?c2tKNUdFeDF2ajlVQzFpQWVnNHJoRTRYTk80Q0ZML2VHd2tRVElWRFErZ2w0?=
 =?utf-8?B?Sk03RHVSMEJmVVQ1eXl1cDFrMEhGblNzVi9DVFFCMUJ5U21nNy9rR1JpOGNI?=
 =?utf-8?B?aTA0aXdjc2VBQzNmU2FUeVJHcjA4QzArT3Q4Rm5ZcDUvRndaNGwzZGlwMS9D?=
 =?utf-8?B?bXFnazJ1STBiVUhCRm41VXVUcldFUXIwbUp6Tmo3Y25jaDFsVzBia1VFd1dx?=
 =?utf-8?B?c3hWV0x5NUdVRmlMcmtZREIrSXBqMnFxR2RNa3RYemVBL29nRll5Vlhtd3NY?=
 =?utf-8?B?Y01lUGMxR3IyQ1FUVkg0bFhGWWJzeFgwQjdvZGRPNmxNVkVXRnRibjlsd1NX?=
 =?utf-8?B?R0tWR01HNVk0N2dCRHJzN05Hb1JhNERzdnpGN2tKZ25BMnBMUk8wOUNtY2hS?=
 =?utf-8?B?elBRZGgxQ3FzVldLV0lLNkN0eGxycDU4dW5la1I3M3NpR3FEQVVIUisxTUgv?=
 =?utf-8?B?bkRxTzNkUUF5cTVmbUFmaEhaczFpWjM5aDJDNHdsUUdzMWdHMnk0VmZNcXN4?=
 =?utf-8?B?KzZhbEw1elNsek5jM0wzTWV3VDNibEFFMGU4L2JNUUJDeno4QUFNOFNRd2tL?=
 =?utf-8?B?QlhrVE1DemxQZEs0Skk3S0lNdEpJU0hMeXFHazlCWEhhWi9HSlZ1SmNrc2cw?=
 =?utf-8?B?alhiZWc2ZmRJcHVxQWpEcVRiSUJCR25hMGRjNnRNTjk2eHE5WVd0alNpOUZi?=
 =?utf-8?B?SWsrRW1DeWxaRStzY1ROZU1mQVpUSG44azFWYWVXRFhZcStCU1MwUFk1UmVm?=
 =?utf-8?B?V09MdjJPNkwzcGJ6Ly9EQ1RBK1NrVmxIZDVNZXJxVWp1QVhxT3JLVnJjZ1Ix?=
 =?utf-8?B?enUxcmt3QW1lMHVVWDI2RWdzdkQ3TmYzWVg4K2g1R25ZOUNjVGpJZzREd0s2?=
 =?utf-8?B?UWR1djg2UnZmenNRclJRVDh0Ni9ObEZpS2R4a0o2K1RZMUc1ZDdrMXB0U0F3?=
 =?utf-8?Q?VmLzHFZ/z7a+Cg4Gu+ZbtII=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?M3dEMCtlRjFNeXp4RVlZUTRiTzNlSTRvM0VwWGlEbzI5bVR4ZSs4bE5uY2tL?=
 =?utf-8?B?L0tETTYwLytuMzRnV1lyUFlQdXhWN1YxamVhdmpoRWwzS1pSVU16TDRXYXE4?=
 =?utf-8?B?R2pxS3BNM2pvSjhqellrTk0wR0dSNkVrS1pDMGxwU1JSVW0rL2FJd0JuU1pP?=
 =?utf-8?B?bG0zUWxQSnlqMlRaeURRVDQrNVVuamduRXZ1RTBGdnE5ZHA0dVF3YW5BZnF6?=
 =?utf-8?B?TzYxMHhzZFdkbmIxcDB5MC9oZWhzOHZjdkFiTHlWbUxLeThtRGhNaXp6b3Bp?=
 =?utf-8?B?NEJqdG54RVVydlluaHBlais2NHpFajZ4aTlhZFNEdE14LzVIamdhcVMvblBQ?=
 =?utf-8?B?RmNuaFNFOVF1bjUwT2Q2aDgrKzE0WUovclZ1Q0JyRDNKelRYNzY4UHBYRlpH?=
 =?utf-8?B?aHppNHNWRTFjc0lJZ3J2Y01oSGFrSnBqdVp0TlBBTFMwY01yS2EwaDRiNy9R?=
 =?utf-8?B?VVRyanZ2UDFSUVhQLzhpOXhJSy9UY3d5dHJhYUp1S0xCUXpoYjRYTWZiNzhT?=
 =?utf-8?B?UnliNVZ6cmlDdEVSaFJMcWZrZHNYUXhBblZkWkw1cnMzcDB4M2thY1V6eWtD?=
 =?utf-8?B?ZTZFUDJrT095dTk0WkRMc3A2aVFFMTBpNStROWtvV21TVGNkdXF6aXhUQS9a?=
 =?utf-8?B?dVNOQTBuUHpJbHhLS045Y2ViYlkvek5WMTl5cE9tNHh6UGM1UGwyalphQ1Zx?=
 =?utf-8?B?YmQyUjVoZ1A1Q0pZcTRnQk9xNlM5L20rK2pCcHYvOGduKzZORTJzTkkvREVv?=
 =?utf-8?B?OUNtOC9JUENQVVhQR2lCL05VTzdIUHNWVVBSVFk4dHVDNGxLcmVRYmwyNHk1?=
 =?utf-8?B?L09RYUwyanVTOWltRHhnN2txUGVoeUl4ZEdDcjdISFFPdWhHSkdpTmhqdUo5?=
 =?utf-8?B?dE1yaTNRNjlnK2NoZVU1NFcwOUZPN1ZaNGtKblduZTlXTFFsTTAwT0o3R0hq?=
 =?utf-8?B?UzJ5Q2ZxMkJDVkR0TW1HKzhLMkNlTEZwWXl1THJiSUQ4RW9vdWZaVmxTUGE5?=
 =?utf-8?B?QkZFcjdsLzZTOEdlbjdSNWd1Z1dXRW5yNWl3Z1kzYis4T2UxU0M1ZVJma29r?=
 =?utf-8?B?OVgyanpoekJNVGs5cjZxZG9reE1MNk10TVNUeGtoRlEwNHEyNGRVWi85NWFO?=
 =?utf-8?B?SXI2WnlzczJLNis1ZWNrVVJhbmtyVlV1YndGNUlzcmhZRkR1VG5OaFhwMHF5?=
 =?utf-8?B?SENQU0REVVZNWldKTjhUOEhoU2EvZ3Jaemp3MVpxUCtDWmdDT1JGenFhNG5w?=
 =?utf-8?B?K2M5T2U2ZWdEQnFHRmNYZzVIeCtqQzFINWpYQm5JNTc0Vk1raTdhNjZsckNU?=
 =?utf-8?B?V2JKWkJXZ3Bxa0FhTlZyOWNQalpsMDZjNm1CV3U2SUg1bmhBRXdYYXNPVlJy?=
 =?utf-8?B?TkNNUXduZWJlMkd5VWFTenBwdFlOa1EzR0NRT1NuOEUxbUI4b2VTVnRhMU9j?=
 =?utf-8?B?VXl4cU5PR21ta0c4ODBrTnJkTWV1V3c2TW5Ta09hMGg2R0QyVldPWk9rZHVx?=
 =?utf-8?B?bEd1eVJvVENQZ3BtdXRIYVErNmFqVXdhc2l4TVBwa2VIeUx0eHJXMExEeUZs?=
 =?utf-8?B?Q0tsVEF3VzRZWHhWVzlPZWlOMlVYZVhMZ1p3S1FDYjlRVjMxZkQ0UmpVUFRS?=
 =?utf-8?B?OExqTDlRdWpIZDVSYlc2TWxabjdLdjBTYVprQnh0U25DdFZmWXgwUEdZL0dU?=
 =?utf-8?B?ZHZtdXN2aTlnSHdkays3VFI2UWxpQ2ttWGdGK1hHWVd2cS9OdTNZQlJuTHRJ?=
 =?utf-8?Q?DWqLZ242nGzwcJBPis=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73bdc13f-6ab8-4e95-ff6d-08db530364d2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 16:10:24.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRw9VzBOQZzh9hFveXaEarvqjbugK1Yw+fiS17cs4bME2lllHPw7xrkiIeFvCQHMM5XToTJ+u2U09cUuym9DVExM0FaDbNcFQUefojD831Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120134
X-Proofpoint-ORIG-GUID: 7PO8d30rEWqb9ffQddNvT_Z80KiyfjL5
X-Proofpoint-GUID: 7PO8d30rEWqb9ffQddNvT_Z80KiyfjL5
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/12/23 07:00, Matthew Garrett wrote:
> On Thu, May 04, 2023 at 02:50:14PM +0000, Ross Philipson wrote:
> 
>> +static inline int tpm12_log_event(void *evtlog_base, u32 evtlog_size,
>> +				  u32 event_size, void *event)
>> +{
>> +	struct tpm12_event_log_header *evtlog =
>> +		(struct tpm12_event_log_header *)evtlog_base;
>> +
>> +	if (memcmp(evtlog->signature, TPM12_EVTLOG_SIGNATURE,
>> +		   sizeof(TPM12_EVTLOG_SIGNATURE)))
>> +		return -EINVAL;
>> +
>> +	if (evtlog->container_size > evtlog_size)
>> +		return -EINVAL;
>> +
>> +	if (evtlog->next_event_offset + event_size > evtlog->container_size)
>> +		return -E2BIG;
>> +
>> +	memcpy(evtlog_base + evtlog->next_event_offset, event, event_size);
>> +	evtlog->next_event_offset += event_size;
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int tpm20_log_event(struct txt_heap_event_log_pointer2_1_element *elem,
>> +				  void *evtlog_base, u32 evtlog_size,
>> +				  u32 event_size, void *event)
>> +{
>> +	struct tcg_pcr_event *header =
>> +		(struct tcg_pcr_event *)evtlog_base;
>> +
>> +	/* Has to be at least big enough for the signature */
>> +	if (header->event_size < sizeof(TCG_SPECID_SIG))
>> +		return -EINVAL;
>> +
>> +	if (memcmp((u8 *)header + sizeof(struct tcg_pcr_event),
>> +		   TCG_SPECID_SIG, sizeof(TCG_SPECID_SIG)))
>> +		return -EINVAL;
>> +
>> +	if (elem->allocated_event_container_size > evtlog_size)
>> +		return -EINVAL;
>> +
>> +	if (elem->next_record_offset + event_size >
>> +	    elem->allocated_event_container_size)
>> +		return -E2BIG;
>> +
>> +	memcpy(evtlog_base + elem->next_record_offset, event, event_size);
>> +	elem->next_record_offset += event_size;
>> +
>> +	return 0;
>> +}
>> +
> 
> These seem like they'd potentially be useful outside the context of SL,
> maybe put them in a more generic location? Very much a nice to have, not
> a blocker from my side.

Yea we can look into finding a nice home somewhere in the TPM event log 
code for these.

> 
>> +/*
>> + * External functions avalailable in mainline kernel.
> 
> Nit: "available"

Ack

Thanks

> 


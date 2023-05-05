Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643246F8925
	for <lists+linux-efi@lfdr.de>; Fri,  5 May 2023 20:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjEES7H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 May 2023 14:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjEES7F (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 May 2023 14:59:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBF51A616;
        Fri,  5 May 2023 11:59:04 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhKIY031576;
        Fri, 5 May 2023 18:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=pry8GVbrG+CEtF4FH9E0CbaI/MzrHh84Qtktw/8/8zw=;
 b=B3HLHFKCgQdIFIF8ycXXJwZobjwEQb3bhs0WMan32yth+CXnSEifVKKAzhPlZNZZJS1Y
 cIHfob1NI03AmuK9jtn7EZ4jLMx5k4fGQal4ck3qte6P43Ia9Ss8HaCmPWjw/yxGCYW0
 2QTbUwDmQC7+7LYhcIWTy2bWQRu5569bLxEwDJ7fqGvsiVKJcWu4lC6d2HXzuZP21EVE
 3LOTZDfYDhzLSt6GHvjJc4AuPNh2j5U53lyeDkzxGv8ff8CKUvvx0V7FS1RRvhyoPQvh
 a6k4H8bFU9DPi2Dir2OLJKidbx4EHKCqf1iT0W7wRkeO28OvLUBc2KUnf254ow4T2l3C hQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9d5stg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 18:58:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345IohcY040488;
        Fri, 5 May 2023 18:58:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spa9jw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 18:58:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLTZYI1Msm8pKZ/30WGgz+TrE8ycQy7kw9loiAhF1i4+ZZNHlW7AMxlPfj0NkvBYuOhgiFgCp7BsqtuAjpDqfzLSwho7NLhj3RGGHx4knv6/OM4Tnla5ckpuDtd98FzfGvJ19UEtKEYjlDhKrkS2hZPYQ/R0Ay1gqhxwDNFv+cQWvHhAYdaPytRx5oTqaOsKo78v80VGJTrtrrx8jdTQuEdmwDsbRc1J+wsNNe99H/hvPrqF4HfJJKOlpR6nRUWuqfXsQuBJkn82djJALG2uCp8qDH91Q44qhhUznZoOQ70YGj3GgkWgg423gTzHDhM2pLsaeoNAKmBPwjYaJ7sGfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pry8GVbrG+CEtF4FH9E0CbaI/MzrHh84Qtktw/8/8zw=;
 b=FRJrCutp7kjF61FDxtxeheUbBVnlmy+tko5Mtjt1WZVxGylDoOxE1eGnv14vNQH2dwEGH2OV+JKyyRsy/7GK0e5bZTaD4krOpa8H57FO/827Fikrh374n5k4Rh9Y3345kj+Rfw9jck9NDe7RA+yhGJuEeKS7nh0HgJjP0J6f2djjbYER9AOP0amVt6nuItKC0TDtTdveu3+p7gRQ7iiRABouui8f0f73XnFVAKKUxKgQLVq0agALJusHB28AOPEHAVJvxER072f78dvOaYyjT3zNFEMWWTzZcUqEqy0fR14eQVNj8q8xKAKr+IOs1CSX3EMxy97WPggioMP5fmxa7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pry8GVbrG+CEtF4FH9E0CbaI/MzrHh84Qtktw/8/8zw=;
 b=jASMhUrXW2n/gtPz5HGmSvt4lb9ivuj5ntCMmZoXuMkdl029cKgSBQ022RQmcRX2N0HzqNJcUI/twu3mllGbsKRPpsSJ69DEn2IqRUZI9RWvL3wJSyVeBJBu1IWJ8EXeUG+s5T57BR2n1RPubNzTKKaHPq0AOvyVRvkUEQ5MOPA=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by PH8PR10MB6528.namprd10.prod.outlook.com (2603:10b6:510:228::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 18:58:33 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 18:58:33 +0000
Message-ID: <81ce947c-07a0-0975-1d09-776fb03c64b9@oracle.com>
Date:   Fri, 5 May 2023 14:58:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 07/14] x86: Secure Launch kernel early boot stub
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
 <20230504145023.835096-8-ross.philipson@oracle.com>
 <ZFVBLCLVK7AAStst@kernel.org>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <ZFVBLCLVK7AAStst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0007.namprd10.prod.outlook.com
 (2603:10b6:610:4c::17) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|PH8PR10MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: d4882146-9ff9-429d-b312-08db4d9ab91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k3m8oRoLXLp5x9ptNFc3Ctd8oImDaa7O1lXeDMGzxytNR1zLR6iftFwlOkaYYj9xhsag31uigQ0ngkyiGPtOCGu7OIffmrReR2C9KeflHZzCCA1TKTy7+C/OPVNk5uUxLJ9U6l7pagmUCMwQfv4YdUWMicg3UDv1Z1IIX5zGx715ljzqGIvfteYkWrT30rbF0oEn3IAnAWTs45U0KBBRBZFNSyLaA5A2P6E6k1uD/GOncEkIIKziNvjC+FerVQilKCKpvly1AZddhnyIGEclH5pGiFO85ldOSjUESaQqor5pdyGYIAL4wFSnHSuhWSzueXD+o13tJoiWnqBAO6p42f9WKveTz+LCcjeZ82dyYsVTA++LgMVOntKvdZ1wyLjRHNR3MHiy1cEO1vnuIDZOQcjjbKqP0bx+KT+kXuwSNnqJNuOhvz0F97aop4kkKOWRgj1HK5EKJxOoKbSmh6hf9PbOKUF2ijoyqNGn9U64j4qAq8esHw06BEJNDeIlACspv9i5UmcEbRkoPmyFfdl25C2VcsfA772OA/BQfpN1mxunxq49omKljCoDlRjW/8z5DMQVRUBp1sPdhlHnRoAumuvZIHLHE6FhXjlEvxeOUfSSw1WpNajEl6a9RMkSdrcQrtX1mgQFqN2235BP51X4wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199021)(2906002)(6916009)(8936002)(66556008)(66946007)(8676002)(316002)(4326008)(66476007)(31686004)(41300700001)(478600001)(7416002)(44832011)(6486002)(6666004)(6512007)(83380400001)(5660300002)(53546011)(6506007)(186003)(2616005)(36756003)(86362001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVd2QkR0YWU1cmcxQVpwcjBqSjRyUzIxc0hxTWFwQTREWGVqVDNkNTlzVGZl?=
 =?utf-8?B?eWYwS0YvWnBEaDN6OTJpMVZCWE52OXl0dWJFTUZKQ2dvOW9mb0Izam9zOUJE?=
 =?utf-8?B?TldQNXQ3TXFMbWluZVAvRXFMRzA2TThIRkZqbnFnV0hLNzhZeFpmVkY1dHZq?=
 =?utf-8?B?dG9qdmV1OTE1eC9xL2I5R2pqWTRyWVBpbE5NK3pQZXVGV1JDNlAxSUdJdzlT?=
 =?utf-8?B?UEhJUEo0bzhuZEtCT2tFWm4vUzhYSWtjMW1zQVBOcXdVZHgxZU4xMmdybnpR?=
 =?utf-8?B?cGxlTkJkTUgzczFPdDVLYURsTmxLOEVIbkFEalB1VEhDZEJDWitOcVMvVEJs?=
 =?utf-8?B?QzgxNUZsL25uekdpemNDT0hhREl2ZnFuZnhBSW9TYW5jdmpyVFJsWDJEQzhJ?=
 =?utf-8?B?Q0FZS0ZXdW84cXZ2TDZ0MGZNNU14QXc0SEQvU0NtUGNEb20weVNyYUNKSE9M?=
 =?utf-8?B?anh1cDhPSGNtaTllSm1zYnlnZzBTZTZ2NUUzNWw3RHlqSjgvcGpzdXRERi9F?=
 =?utf-8?B?TDVEWjlFV2d2TjhUMmw3NlhFVytpNU41ZjZFRUd2ZFluOHRUaEJGZmM2TE8z?=
 =?utf-8?B?Nk5XMytqMDhjU2JxWG5JTGdrcmllZjI5dWJnSUhxTVZsemMrcVdxVU5YeWhv?=
 =?utf-8?B?NUhNbmdkS3o4b3Qyam5NVlhIaWhNV2pnWkpwWGc1NlAvRm1zV2kvelJ1aWVN?=
 =?utf-8?B?U3RYNXFQVFl1R3BIQzU1VGZjNFpMc0V5anI0YWk5VlBCSjBlb0M4NHFBREw1?=
 =?utf-8?B?S1MxZ2tIRUpNdHVvUHVMd3BKbVRyQ042N2ZUeG1FMDE4SktpMGZvZk1WSHh3?=
 =?utf-8?B?T2hUY0pscXVLK0M3QlpOVnpwa1owTG9uM0NmSjAzMUxTeCtwSU55d2lKa3pi?=
 =?utf-8?B?UURmdUs4U2UxbHlBejNwWHAzV2hCb2R6dGQ3ZmlIRTFrY0I2QWpMVUtsMFRV?=
 =?utf-8?B?cktBTUpvZ1VDNmk2aFpYUmxuK0NsbExZNVhkMHRZYW1ZOXhUK091dUVKNjQx?=
 =?utf-8?B?MEJNLzJ3OU9IQ1piRkRGbzRiRHFCUXZxTXdvWUo0YnNEN0dpV1NsZXhBeUQ4?=
 =?utf-8?B?VFBSbWlDUzA1SzhYMXB2SC9tN05SOWJDYXNoMllwM0FlcWR5ZjM3SUVYZGpx?=
 =?utf-8?B?ZDBubVpvbUNpOG1yOFVydTArcnVPZnF2eTdENE9DMGdYVXUrb3o5ZzR6dTA0?=
 =?utf-8?B?emM3b1poNVFOc2ZLeUZnRnFkT2ZBYXN2Vkd3T0oyR0xOVWNLVXgvQXZ1TE1o?=
 =?utf-8?B?UnUwMzdkc3FPdC90TkthTk9EMmw2d1JVSk9ocWNxdHVCanhaWldWbzcvSE5z?=
 =?utf-8?B?SEZQeVJmdEFtNzV6a3F1ai9kUkxSVGZzN2pUVTdibWN0UGduemlkcFdTUXVo?=
 =?utf-8?B?aUp0RnArdFpCVFAwakN2MFRkbU9ucThiVXVGRXRTcXRaS0Mybm5Xd04wUVZG?=
 =?utf-8?B?MWlYK09FOGNreDdMR2FFd011cDZrN1BlaVJkb0tBMVhESE1zZHRSSndqTDlm?=
 =?utf-8?B?Nktsd01QUkFkN0Nrc1JGR092WG1rYmR5dUJsSC9TQ1dWQ2RwRTFMMVBMeVo0?=
 =?utf-8?B?SXhkQXoxeEJMZzFxM3dTUDJmU1hnWGJoZUIrUzRIWFhTaEJleEZELzZzYWcr?=
 =?utf-8?B?VDlmNFExTHJGMjB0aWJpTS9KMFpadERvYklnQys0blJhaU10R3ZJckJnSFdm?=
 =?utf-8?B?Y3hBaytxR2Zsejh1OS9IbHQvWTNrSjFKTExWTmtGRFlTTHR3S2ZhNVBnNHUw?=
 =?utf-8?B?L2poMWUxdXliV3llQjNGZmJYVks1b2xoRndxdnZPYUNNd2VzNXl1bnc4K05D?=
 =?utf-8?B?UGhuNC9yaXJGRGMwTVFqRCs3RkhpSGhwbCtUSTZ6M2ZXSUVYTVFpT1ozeEJm?=
 =?utf-8?B?cEJZdnNuK3oxRm1MaERyeDhzUHNlMlNtUmIxb0VMaGJtM0xMNC9GM3ZDMzJF?=
 =?utf-8?B?bU9WTGh5amo0YzNIZmFPOU9TNW0yblJiMDRkRXhjQWxLcnlYRXYrWklkMlV5?=
 =?utf-8?B?WnNhaE5ERHZJb3FyQWZJNHBZWUNhbFQrRS9uaU5oajZTM3QrVEIwd2Z0YzJm?=
 =?utf-8?B?ZnVGSlBObkdTMldVUTRvUVdDZ29sTnA0WGhSQlo0alI5MVpxVW5pc3EzWlBU?=
 =?utf-8?B?L3dwR0VKYUxuWWpLUmRLUlNMWEFlWloyK1JnUVBoV01CY1NnenBTaW92emJz?=
 =?utf-8?Q?nbjjHONHymllOvprN4grRVM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eENMUTNKWEcyMXh2cCtXYmJrcFdzdTNJTGlOamtjemtISEV1VVZTQmx5aUVW?=
 =?utf-8?B?MU5Fc0FIVnFzUitaODRIa0RjQ3ZUeUtYdjJGOTcvTUVmNmpteklXTmlEaVBY?=
 =?utf-8?B?NjdnR2d1MTZxa0FFeGZvVlEyZXJiUWtJbnhIWGdkQlRUL3p3RnYrSFM1aE1Z?=
 =?utf-8?B?TlJRUUwyRE1rZDQ5VEpCc1JVTEJDUXJpeU9UelNHbWFQbXA1ejlEeG1jS25X?=
 =?utf-8?B?WERnT2xNemt0UGE2a3FscnA2LzNuRHlIWkRTLzNGVHRISTQ5UE9IcnVLSzlr?=
 =?utf-8?B?a1p6Rkp1L05YcVRyb1ZTdkEwUWFjWWpoZFhScWtwWjN3enlkQUx6N3FQdWZK?=
 =?utf-8?B?ZUNOSHNhMDFJT3ZScUZOMzd3RkJ5dVU1ZjFsazNJcXJZMHMxaFl6SDhXSGlH?=
 =?utf-8?B?STZVaFRHblRYaVhDUEp5anBXWWc0d0Jla1lUai9lMmFMOGVpOVh4ZCs4QjRD?=
 =?utf-8?B?SHdSMnMyQlR6QkNWSEFrTXdXL3ZIV0FiTVl0b01TaU5tSkNLVEVtWUVzZ0Vu?=
 =?utf-8?B?dnJkaWNEeXRsUDZ0VmF1MzEzQXVrUXQrZ3pXZE1aZ0szdy80dUtqVVRVeEZt?=
 =?utf-8?B?OWhmVHhmZlNEZ09qdnd2L1RhaTVrMUt0MWhxRXNHamdLSEdDVTd4Tm1UQkF0?=
 =?utf-8?B?VHg1cm8vY1kwd3BXWmpEalo0bllTRGlBL3dCV2F2aWxpdmVzM3Y2ckdsKy9j?=
 =?utf-8?B?eE1pcWhGSjNMaTJvVmJvd2w5ZEp0R255Ujh5eVkrMkF2c0ljZnBUL3BQaENh?=
 =?utf-8?B?QkVIdVJYVUh4MGhxYVhYeEpuMW8ra2VvS3BXQUFkQnNtNzV5UHIwRHFlcDRw?=
 =?utf-8?B?bDVBWTgxS2crajc4RUxrSy8vYlpOMk5tS3prbGlOakhFSi9od2Vjalpyamhp?=
 =?utf-8?B?dzIrOEhNQlB0MmhDVU5Dc0ZvQW1jUTg1U1pMVFlFSHVaZmxMZHNjcFF2SlMr?=
 =?utf-8?B?UmZEbDBjYTIxalNqaGtjVVZwY0g0dms3RThRaVlsU0pKK1VDSzZ4TWxZc3RF?=
 =?utf-8?B?ckJnaVZ6NFhOTHVjV1FJSDQ5REJEMGd0OG1ETUt5VGsxdXUzUjBjRHA1U0dj?=
 =?utf-8?B?QzZ2akRGdWFtTFY4ZDRMVlFFWVVaK2FFRTl5SGdpSDB4RDl0Z29lanQvSVFy?=
 =?utf-8?B?V3JpVGVzQmh2QU02Y3RqQlZFQ3VnaE5sYk5WTjBnUkpXT1NzRm90NUdEZFZU?=
 =?utf-8?B?SHp1UmREWnNaZjVveTJxOGpzTitaV2ZpcExiYW0rU0xmcWNyUnBKRHcvaVVG?=
 =?utf-8?B?QW9vc1p4QXpMTFJHRGUxSnBmZ2xTdkZSc0pGUDg5VU80dGhhNG1HQmhIWUgv?=
 =?utf-8?B?OVNJVGN2eVNWL3N4clA0V2VQalJSVktHUGY1Si9JMkFHMnVQNEVkd3lIN25K?=
 =?utf-8?B?OWliY1pjWG4wdHo4Wk5FZFZBTjgyc1Q3RXg1S0dCdnpLbEUzZWVDTnUyVkwr?=
 =?utf-8?B?eWplSjA0ZXBUdzdITU5adnB6NEE3Z0hqWktVbHpGN2U2cnNXa0RoWW1PRW1Q?=
 =?utf-8?B?L1MyTVF2YVVEbDIyeEFWVVk3d2QxMVQrazRzdW9sRmQ1T0JVeDl3Nk91QnAw?=
 =?utf-8?B?YXg3WmFiY1dEK0NobHRPcFptQW5YU0FmNWYxNHJSM3VzdzNIczdsZDNlbElN?=
 =?utf-8?B?TnlxcUpwaS92dlNzWHJtMmRiWG5OSGtQeUU3UlpmVDE0OE94SExyOXI1Sk04?=
 =?utf-8?B?a2NPSWc4OWovV2RFb0tpOHMrTC9GV01sd0YxSmZZdUxFSVVwNFl6UnVxS1R6?=
 =?utf-8?Q?MYZQabEBeLCJU2ezeU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4882146-9ff9-429d-b312-08db4d9ab91a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 18:58:33.1885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGi5gCEWbPrPj04izK8AqvlRAHQVFJQGEF7x1XOayJzpuFj4EX4LyXMnQgXRvuS8J4CBw6Xa/ydR4jB2TON/SQ+pWNuZWv0xOjQjxPpST+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6528
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_25,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050156
X-Proofpoint-GUID: EtA2dQCsd5cc4m3Nr2_BeqEg4pd3hOZC
X-Proofpoint-ORIG-GUID: EtA2dQCsd5cc4m3Nr2_BeqEg4pd3hOZC
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/5/23 13:47, Simon Horman wrote:
> On Thu, May 04, 2023 at 02:50:16PM +0000, Ross Philipson wrote:
>> The Secure Launch (SL) stub provides the entry point for Intel TXT (and
>> later AMD SKINIT) to vector to during the late launch. The symbol
>> sl_stub_entry is that entry point and its offset into the kernel is
>> conveyed to the launching code using the MLE (Measured Launch
>> Environment) header in the structure named mle_header. The offset of the
>> MLE header is set in the kernel_info. The routine sl_stub contains the
>> very early late launch setup code responsible for setting up the basic
>> environment to allow the normal kernel startup_32 code to proceed. It is
>> also responsible for properly waking and handling the APs on Intel
>> platforms. The routine sl_main which runs after entering 64b mode is
>> responsible for measuring configuration and module information before
>> it is used like the boot params, the kernel command line, the TXT heap,
>> an external initramfs, etc.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> 
> ...
> 
>> diff --git a/arch/x86/boot/compressed/sl_main.c b/arch/x86/boot/compressed/sl_main.c
> 
> ...
> 
>> +static void *evtlog_base;
>> +static u32 evtlog_size;
>> +static struct txt_heap_event_log_pointer2_1_element *log20_elem;
>> +static u32 tpm_log_ver = SL_TPM12_LOG;
>> +struct tcg_efi_specid_event_algs tpm_algs[SL_TPM20_MAX_ALGS] = {0};
> 
> tpm_algs seems to only be used in this file.
> Should it be static?
> 
>> +
>> +extern u32 sl_cpu_type;
>> +extern u32 sl_mle_start;
>> +extern struct boot_params *boot_params;
>> +
>> +static u64 sl_txt_read(u32 reg)
> 
> Perhaps reg should have an __iomem annotation.
> 
>> +{
>> +	return readq((void *)(u64)(TXT_PRIV_CONFIG_REGS_BASE + reg));
>> +}
>> +
>> +static void sl_txt_write(u32 reg, u64 val)
> 
> Likewise here.
> 
> ...
> 
>> +static void sl_check_pmr_coverage(void *base, u32 size, bool allow_hi)
>> +{
>> +	struct txt_os_sinit_data *os_sinit_data;
>> +	void *end = base + size;
>> +	void *txt_heap;
>> +
>> +	if (!(sl_cpu_type & SL_CPU_INTEL))
>> +		return;
>> +
>> +	txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
>> +	os_sinit_data = txt_os_sinit_data_start(txt_heap);
>> +
>> +	if ((end >= (void *)0x100000000ULL) &&
>> +	    (base < (void *)0x100000000ULL))
>> +		sl_txt_reset(SL_ERROR_REGION_STRADDLE_4GB);
>> +
>> +	/*
>> +	 * Note that the late stub code validates that the hi PMR covers
>> +	 * all memory above 4G. At this point the code can only check that
>> +	 * regions are within the hi PMR but that is sufficient.
>> +	 */
>> +	if ((end > (void *)0x100000000ULL) &&
>> +	    (base >= (void *)0x100000000ULL)) {
>> +		if (allow_hi) {
>> +			if (end >= (void *)(os_sinit_data->vtd_pmr_hi_base +
>> +					   os_sinit_data->vtd_pmr_hi_size))
>> +				sl_txt_reset(SL_ERROR_BUFFER_BEYOND_PMR);
>> +		} else
>> +			sl_txt_reset(SL_ERROR_REGION_ABOVE_4GB);
> 
> nit: if any arm of a condition has '{}' then all arms should have them.
>       So:
> 
> 		} else {
> 			sl_txt_reset(SL_ERROR_REGION_ABOVE_4GB);
> 		}
> 
> Also elsewhere in this patch.
> 
>> +	}
>> +
>> +	if (end >= (void *)os_sinit_data->vtd_pmr_lo_size)
>> +		sl_txt_reset(SL_ERROR_BUFFER_BEYOND_PMR);
>> +}
>> +
>> +/*
>> + * Some MSRs are modified by the pre-launch code including the MTRRs.
>> + * The early MLE code has to restore these values. This code validates
>> + * the values after they are measured.
>> + */
>> +static void sl_txt_validate_msrs(struct txt_os_mle_data *os_mle_data)
>> +{
>> +	struct slr_txt_mtrr_state *saved_bsp_mtrrs;
>> +	u64 mtrr_caps, mtrr_def_type, mtrr_var;
>> +	struct slr_entry_intel_info *txt_info;
>> +	u64 misc_en_msr;
>> +	u32 vcnt, i;
>> +
>> +	txt_info = (struct slr_entry_intel_info *)os_mle_data->txt_info;
>> +	saved_bsp_mtrrs = &(txt_info->saved_bsp_mtrrs);
> 
> nit: unnecessary parentheses
> 
> ...
> 
>> +static void sl_validate_event_log_buffer(void)
>> +{
>> +	struct txt_os_sinit_data *os_sinit_data;
>> +	void *txt_heap, *txt_end;
>> +	void *mle_base, *mle_end;
>> +	void *evtlog_end;
>> +
>> +	if ((u64)evtlog_size > (LLONG_MAX - (u64)evtlog_base))
>> +		sl_txt_reset(SL_ERROR_INTEGER_OVERFLOW);
>> +	evtlog_end = evtlog_base + evtlog_size;
>> +
>> +	txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
>> +	txt_end = txt_heap + sl_txt_read(TXT_CR_HEAP_SIZE);
>> +	os_sinit_data = txt_os_sinit_data_start(txt_heap);
>> +
>> +	mle_base = (void *)(u64)sl_mle_start;
>> +	mle_end = mle_base + os_sinit_data->mle_size;
>> +
>> +	/*
>> +	 * This check is to ensure the event log buffer does not overlap with
>> +	 * the MLE image.
>> +	 */
>> +	if ((evtlog_base >= mle_end) &&
>> +	    (evtlog_end > mle_end))
>> +		goto pmr_check; /* above */
> 
> Ditto.
> Also, the if condition could be one line.
> Also in several other places in this patch.
> 
>> +
>> +	if ((evtlog_end <= mle_base) &&
>> +	    (evtlog_base < mle_base))
>> +		goto pmr_check; /* below */
>> +
>> +	sl_txt_reset(SL_ERROR_MLE_BUFFER_OVERLAP);
>> +
>> +pmr_check:
>> +	/*
>> +	 * The TXT heap is protected by the DPR. If the TPM event log is
>> +	 * inside the TXT heap, there is no need for a PMR check.
>> +	 */
>> +	if ((evtlog_base > txt_heap) &&
>> +	    (evtlog_end < txt_end))
>> +		return;
>> +
>> +	sl_check_pmr_coverage(evtlog_base, evtlog_size, true);
>> +}
> 
>> +static void sl_process_extend_policy(struct slr_table *slrt)
>> +{
>> +	struct slr_entry_policy *policy;
>> +	struct slr_policy_entry *entry;
>> +	u16 i = 0;
>> +
>> +	policy =(struct slr_entry_policy *)
> 
> nit: space after '='
> 
> ...
> 
>> +static void sl_process_extend_uefi_config(struct slr_table *slrt)
>> +{
>> +	struct slr_entry_uefi_config *uefi_config;
>> +	struct slr_uefi_cfg_entry *uefi_entry;
>> +	u64 i;
>> +
>> +	uefi_config =(struct slr_entry_uefi_config *)
>> +		slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_UEFI_CONFIG);
>> +
>> +	/* Optionally here depending on how SL kernel was booted */
>> +	if (!uefi_config)
>> +		return;
>> +
>> +	uefi_entry = (struct slr_uefi_cfg_entry *)((u8 *)uefi_config + sizeof(*uefi_config));
>> +
>> +	for ( ; i < uefi_config->nr_entries; i++, uefi_entry++) {
> 
> nit: i seems to be used without first being initialised.

All the ones prior to this we will fix.

> 
>> +		sl_tpm_extend_evtlog(uefi_entry->pcr, TXT_EVTYPE_SLAUNCH,
>> +				     (void *)uefi_entry->cfg, uefi_entry->size,
>> +				     uefi_entry->evt_info);
>> +	}
>> +}
>> +
>> +asmlinkage __visible void sl_check_region(void *base, u32 size)
>> +{
>> +	sl_check_pmr_coverage(base, size, false);
>> +}
> 
> I'm a nit unsure, what to do here, but clang-16 with W=1 says the following.
> 
> arch/x86/boot/compressed/sl_main.c:533:27: warning: no previous prototype for function 'sl_main' [-Wmissing-prototypes]
> asmlinkage __visible void sl_main(void *bootparams)
>                            ^
> arch/x86/boot/compressed/sl_main.c:533:22: note: declare 'static' if the function is not intended to be used outside of this translation unit
> asmlinkage __visible void sl_main(void *bootparams)
>                       ^
>                       static

Yea we will have to look into why this is. This function is only ever 
called from asm code so that might have something to do with this.

> 
> ...
> 
>> diff --git a/arch/x86/boot/compressed/sl_stub.S b/arch/x86/boot/compressed/sl_stub.S
>> new file mode 100644
>> index 0000000..2d8aa3a
>> --- /dev/null
>> +++ b/arch/x86/boot/compressed/sl_stub.S
>> @@ -0,0 +1,690 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +/*
>> + * Secure Launch protected mode entry point.
>> + *
>> + * Copyright (c) 2022, Oracle and/or its affiliates.
>> + */
>> +	.code32
>> +	.text
>> +#include <linux/linkage.h>
>> +#include <asm/segment.h>
>> +#include <asm/msr.h>
>> +#include <asm/processor-flags.h>
>> +#include <asm/asm-offsets.h>
>> +#include <asm/bootparam.h>
>> +#include <asm/page_types.h>
>> +#include <asm/irq_vectors.h>
>> +#include <linux/slr_table.h>
>> +#include <linux/slaunch.h>
>> +
>> +/* CPUID: leaf 1, ECX, SMX feature bit */
>> +#define X86_FEATURE_BIT_SMX	(1 << 6)
>> +
>> +/* Can't include apiddef.h in asm */
>> +#define XAPIC_ENABLE	(1 << 11)
>> +#define X2APIC_ENABLE	(1 << 10)
>> +
>> +/* Can't include traps.h in asm */
>> +#define X86_TRAP_NMI	2
>> +
>> +/* Can't include mtrr.h in asm */
>> +#define MTRRphysBase0	0x200
>> +
>> +#define IDT_VECTOR_LO_BITS	0
>> +#define IDT_VECTOR_HI_BITS	6
>> +
>> +/*
>> + * See the comment in head_64.S for detailed informatoin on what this macro
> 
> nit: s/informatoin/information/
> 
> ...
> 
>> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
>> index 01d19fc..74e3e7df 100644
>> --- a/arch/x86/include/uapi/asm/bootparam.h
>> +++ b/arch/x86/include/uapi/asm/bootparam.h
>> @@ -26,6 +26,7 @@
>>   /* loadflags */
>>   #define LOADED_HIGH	(1<<0)
>>   #define KASLR_FLAG	(1<<1)
>> +#define SLAUNCH_FLAG	(1<<2)
>>   #define QUIET_FLAG	(1<<5)
>>   #define KEEP_SEGMENTS	(1<<6)
>>   #define CAN_USE_HEAP	(1<<7)
> 
> nit: please consider using BIT()

I am a little reluctant to change something like this in an existing 
header. It seems a bit out of scope for the patch set.

Thanks
Ross

> 
> ...


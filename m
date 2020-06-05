Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A301EFD41
	for <lists+linux-efi@lfdr.de>; Fri,  5 Jun 2020 18:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgFEQJz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Jun 2020 12:09:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34280 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbgFEQJz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Jun 2020 12:09:55 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 055G158k014681;
        Fri, 5 Jun 2020 09:09:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=WescokoYp1d4gmuv8UKYvBdp6ce8SxAnkgAkndhfOLE=;
 b=haFoN6I/sv38c/FMG3oHsRz9dyMFNedKh2NldGubw0ZbkUbMl0SqWXVyIFm+YiHJIfRG
 YeUb8/MidQVFH7WyMcKdO3G3puLplODBAiGudwZFtIdvBcmoCKTpPKkF0pbchpFx0a7t
 dzv2fDrC3cR8MgoY62MuQnw5d2krsSUojmQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31f90uc1kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Jun 2020 09:09:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Jun 2020 09:09:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lX92ewWUZDw4GB4fDgPrQyGr3tHYCiPode4uGBfZxWm1MQ8Vfqax5kv9QijorvVfR0f+czcnVPZx1YgoLPb/olqQJ8MAVM1Sc5+2g9HYMqkyMH3StyXUqqsKTTgLqDf7HKhWP/1JE0wbsR7rsYnWEmpNAcG9W7ESQT6Db3vVKs2+CxaFr+MLeV/smfF92q+uxorkLJb83TMzAfuhzYf01K96b3eewJufdcdU9f840l0u3gg+eRh25U1LB6NrTzUTDKW+NVYfuBBQt7sGrb6aK3ZPAINC50Fn0mR6CRU1R4DIO43J0jP3PwfsCriTAeLMb1lp3XuRZ6/pMJ8XIEehNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WescokoYp1d4gmuv8UKYvBdp6ce8SxAnkgAkndhfOLE=;
 b=GsZUid0AaxDl3dD+JDRlqdHeylEJqY3ho35TGybQgD/HXVst+VYUjxnUWLiwsBauIf4f3kYhHfJom6DnSy7JYlaWrYzQsi0JeYbIBNy9rsWz9Rozy/LugE6kP7H1guo7QsgSc6SiwQrtSGGVNu5K+kDLhKicb1tZeVJCuEWJkVRjNDzOx45MJatVSiD4b4XzuDwov4E5VxtVuMjrduNWWBG+GzTt1ZKMI/O0dQ7KVWhBE/ObRlYpU9I3dKsOR4qPCCRN4CJAdbjgiG5mvizE3+an71My04kgKam5340nSVRK+MY2yhctAhIIwRrvGE9hUUR6e94aSkv7qOTNKqd8tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WescokoYp1d4gmuv8UKYvBdp6ce8SxAnkgAkndhfOLE=;
 b=H3OBfkJVPyYDTkRVT2+DhF5b7Hhx8026FtzWDSepmSrBUXJT7OxkoTyb2Ke70v1Jf5+zBYzkYmR9u+wpgyml6/WtZuzrhWecSg91sZ4+xog1qeGtOrksMGCXYZ0JYAH8Tbq52BSwNi6Y28C/AYfTpWuGGQ/BpQ4E0Oap+IWovRM=
Authentication-Results: alum.mit.edu; dkim=none (message not signed)
 header.d=none;alum.mit.edu; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20)
 by BYAPR15MB3062.namprd15.prod.outlook.com (2603:10b6:a03:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 16:09:48 +0000
Received: from BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::bd0e:e1e:29fb:d806]) by BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::bd0e:e1e:29fb:d806%7]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 16:09:48 +0000
Date:   Fri, 5 Jun 2020 09:09:46 -0700
From:   Andrey Ignatov <rdna@fb.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
CC:     Ard Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <bpf@vger.kernel.org>
Subject: Re: [PATCH] efi/x86: Fix build with gcc 4
Message-ID: <20200605160946.GA46739@rdna-mbp.dhcp.thefacebook.com>
References: <20200605133232.GA616374@rani.riverdale.lan>
 <20200605150638.1011637-1-nivedita@alum.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200605150638.1011637-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: BYAPR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:40::31) To BYAPR15MB4119.namprd15.prod.outlook.com
 (2603:10b6:a02:cd::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:400::5:4abe) by BYAPR04CA0018.namprd04.prod.outlook.com (2603:10b6:a03:40::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 16:09:47 +0000
X-Originating-IP: [2620:10d:c090:400::5:4abe]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3ba1641-0dd2-48f7-62ca-08d8096ade89
X-MS-TrafficTypeDiagnostic: BYAPR15MB3062:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3062DB41DC406058A632AD59A8860@BYAPR15MB3062.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Llzge2HPHhfjJQNXSXygsY4jm9728xbKbYFfFgL2Q9WMV44V9IgInldqP8zgYRPTWJL7THIeRKGihNhTkbRdv9unaORy7rzE05YJF567Qc7hyRVdAysEH6ej06KJfINQuWxe2AOQQZbk6ezyrcGhE1HP2+7TatYzLEgimHPF533WFKypWpD0grIm8gJhmhOSEzXgyGuBcoU0wb1ABUJXoEMiTSL90zFIfUDMPC+fQ5pjUXmFnUEsk+Nt8SYJNLgRWcBeHIR6llKyLEViSk5qMXcYObRt863M3pGRy8tX94OmeRDrtXJY13uKskP9eekK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4119.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(376002)(366004)(396003)(136003)(8936002)(6496006)(52116002)(316002)(478600001)(1076003)(8676002)(6916009)(33656002)(4326008)(5660300002)(83380400001)(66476007)(9686003)(66556008)(66946007)(6486002)(86362001)(2906002)(186003)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ULh2Q5Ch5f581ie7L+WEuf7o+pwOZMQDTIBCBJXgVmucqidFO8JkoQlyWHGO99FJbiZfuxNsVNSPMFBYypYLOdMz+1/za7ARxisqi9F2pcWWmqeW130L8w+yF9ybZsxWeWK1ymz2nE4tKjTkgznJRC0HogebKs05hTuL/WyFvUSeCgMbaNEHrCgszuOHTZQrs+nsMuM3O910bD//+l6/qQzXjl2CDozbYZFe3vr2Nm8fZjUIVDhrfxVUcRynVYQEoR09aifuxDQaCeXLCSgdgdKCl8CGQ/g4TRwG2YP9Q4OulkmIZTTfJ5vzB2eDVEMK7aGhS7rYl/ucW2RpAXUbw1rEQ8u+JKhCyQF9MTonveWoyxNKOH41dUzO0SmFTpp5UWlC0rhLFRqPpeQg/ovp4spZM/DvsqHcBm7UgnvoPc7Pxcf03eYlyXRjGy9il6jLpLL7ZUfGDn4BT4kmnWt94nrII+8QC1ERSPMsGyEMfetcoxDKrpbrVTYed7eLoKylgYwcEE1B+/yC5bFAo0LCvA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ba1641-0dd2-48f7-62ca-08d8096ade89
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 16:09:48.0602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iH5Ph5dkvaH0ewvl8ZcuWI7hNBlFDGUwDqMd06CWWTLD+9NoZ2Io7F9SlUK86v+a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3062
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_04:2020-06-04,2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 lowpriorityscore=0 cotscore=-2147483648 mlxscore=0
 malwarescore=0 adultscore=0 spamscore=0 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050120
X-FB-Internal: deliver
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Arvind Sankar <nivedita@alum.mit.edu> [Fri, 2020-06-05 08:06 -0700]:
> Commit
>   bbf8e8b0fe04 ("efi/libstub: Optimize for size instead of speed")
> 
> changed the optimization level for the EFI stub to -Os from -O2.
> 
> Andrey Ignatov reports that this breaks the build with gcc 4.8.5.
> 
> Testing on godbolt.org, the combination of -Os,
> -fno-asynchronous-unwind-tables, and ms_abi functions doesn't work,
> failing with the error:
>   sorry, unimplemented: ms_abi attribute requires
>   -maccumulate-outgoing-args or subtarget optimization implying it
> 
> This does appear to work with gcc 4.9 onwards.
> 
> Add -maccumulate-outgoing-args explicitly to unbreak the build with
> pre-4.9 versions of gcc.
> 
> Reported-by: Andrey Ignatov <rdna@fb.com>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Thanks. I confirmed it fixes the problem on my setup with gcc 4.8.5 and
also works as before with clang 9.0.20190721.

> ---
>  drivers/firmware/efi/libstub/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index cce4a7436052..d67418de768c 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -6,7 +6,8 @@
>  # enabled, even if doing so doesn't break the build.
>  #
>  cflags-$(CONFIG_X86_32)		:= -march=i386
> -cflags-$(CONFIG_X86_64)		:= -mcmodel=small
> +cflags-$(CONFIG_X86_64)		:= -mcmodel=small \
> +				   $(call cc-option,-maccumulate-outgoing-args)
>  cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
>  				   -fPIC -fno-strict-aliasing -mno-red-zone \
>  				   -mno-mmx -mno-sse -fshort-wchar \
> -- 
> 2.26.2
> 

-- 
Andrey Ignatov

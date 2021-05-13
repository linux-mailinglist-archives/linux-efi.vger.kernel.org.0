Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F09337F257
	for <lists+linux-efi@lfdr.de>; Thu, 13 May 2021 06:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhEMEhY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 May 2021 00:37:24 -0400
Received: from mail-co1nam11on2074.outbound.protection.outlook.com ([40.107.220.74]:31403
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229471AbhEMEhW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 13 May 2021 00:37:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjqJo5JrI0/B1IpdOOBQabqJMxWbxdZbp7asFUu+Fu7m0ipudTy3OeBHcgox6vMyq9msKPsX6lBPQs4MMoE2ARwpPBBkmdodiyZkg1VGQ9ZXyGh14MYyxdw/tEbILRP0jM3U0gPlurTzQIYT5kz3fIRloMh6o7DMGemAc//YvL0kpU6kcsJsREtx+fMGbFdUwz12HaZFG2snokxiOCDWsW18i4FQuj9LwbWKVmxgcrbnocm/EAGJoreL1wcWK0k5iaoxFJIzBLKgoriMoU10GKos9Jw7patzBq0K4QRTmD3M/eO/6YONNH6iQQKmph46aGv12rwxt4Zin5IVz+u0iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4AwDUSlQNjPwRXsPz01bK32LfhQ3pqQpry2sil7lVg=;
 b=OHXfRvTvNkrJnGSgJoATrHvEgUmOrB+4KhPPHD5BhG0SOYNFkGQdcZOZ2YmAtc+TfFl1GjdnEWrDoJRIwe2wsimphHxUHHc1cMfZxvqvzq1+YHSKRMUxUJprZ8HpjdyHGMBteILqYdeo3hBLzThznhmqJb2vEUkSUqr7hl0ZCdnxRLWnETOXv8V+OlbtNBQKl2DxNsm8easdMA1RP7ET0XaMNm3hSnDLcUaJq0SLrx0RkEhBRcBsykMH8nwMOhMzMB/9TvNQmT8dF0RdY+yy49zXWH3wi75a7mbMSUvs2grCPDSGBNRtxnIt2+iFMNP8+sdkpJLXUYtOeHPB4LMNfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4AwDUSlQNjPwRXsPz01bK32LfhQ3pqQpry2sil7lVg=;
 b=lv9oNXEyb6wd7zi1iUJ2n/h53l7BUhR4doT62qm4Gq5ctmj8+Btt8NI9FN8aX5psSF4MvP/0Dz2aOw5LTW3udtIj1qOcI0jS+1StzCx10DNFSKVSopBj4OaoJRKvqXq/6fhy9GqE5X2TjgqYmZ61phHGVflZziL1lwB4vtono4M=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4573.namprd12.prod.outlook.com (2603:10b6:806:9c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 04:36:11 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::1fb:7d59:2c24:615e]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::1fb:7d59:2c24:615e%6]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 04:36:11 +0000
Date:   Thu, 13 May 2021 04:36:09 +0000
From:   Ashish Kalra <ashish.kalra@amd.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        X86 ML <x86@kernel.org>, kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srutherford@google.com, Sean Christopherson <seanjc@google.com>,
        venu.busireddy@oracle.com, Brijesh Singh <brijesh.singh@amd.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] EFI: Introduce the new AMD Memory Encryption GUID.
Message-ID: <20210513043609.GB28019@ashkalra_ubuntu_server>
References: <cover.1619193043.git.ashish.kalra@amd.com>
 <f9d22080293f24bd92684915fcee71a4974593a3.1619193043.git.ashish.kalra@amd.com>
 <YJvV9yKclJWLppWU@zn.tnic>
 <CAMj1kXE0U4JxCLYPhetENDpXKMOAEXs8-dpce+CvBcgifQz2Ww@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE0U4JxCLYPhetENDpXKMOAEXs8-dpce+CvBcgifQz2Ww@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN7PR04CA0170.namprd04.prod.outlook.com
 (2603:10b6:806:125::25) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by SN7PR04CA0170.namprd04.prod.outlook.com (2603:10b6:806:125::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Thu, 13 May 2021 04:36:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1cad826-b653-4c7c-34c5-08d915c8a280
X-MS-TrafficTypeDiagnostic: SA0PR12MB4573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45731A2AF4EFE0AF4C374A698E519@SA0PR12MB4573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muL7Udw+A4ky4honAGWXSSwC3gCM1Jc+xsmAw1QMO0Uu4dsI+7J7iIU2FOqc8Ita8HNyToY+hbGilBMW88iYXqmCWRASguUyNHU8Qall3NF47eWazSRZMHtQjMTTbYcnvfcR2hFQAGPtj0/48dB2890zMh5rgwbyORPj3xUhN1+jinoHiCOArxEHAr43Rj+CbNb92OsujnDZ6ou1mh50H4uJqNMFgGRXRgvY927G9satq0/sVDnGSIvCJgxaszTqvXhT6j2gsiorShsLcZ0ZN44c5UdKqQyeA2HOe6675ne4ZCLFIRHo7sM3XBcJgluevJiqTWc9iBqwDLCbvAcrB9Fvv/Ume1xgiD2MAxddk7xBEr5Jx3LEToSv464UKWZWOuLOVJIZJ+BuPckFQrCtyr8dWnQ95qqDntzGP/DyYRLOB8fmERjYYIm1C/JQhULxHE8JAusFvi85apTK1M0j5apPTxiLS8xcIeSNAj0hIsE6/E8xG1KuWX3RwGvTu3kvtJVIktq3JMsGpIzrmbUSN4hO4be9jYRo0SYS8Y+KoFMuuYeoRSQGbjPiWK8px3pQ9+vRHJ41hG6gY+LB1lGlIu0++1uXAInKa3yGiJOLKhvoXvdk/u+GiAwtnq8gHSKGQrd0Vv+5L9C+x2kxoWf/s8BpbLYEkEJI0JZDVPq+Jyc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(33716001)(7416002)(26005)(6496006)(83380400001)(44832011)(4326008)(2906002)(55016002)(52116002)(9686003)(8676002)(1076003)(478600001)(5660300002)(16526019)(38350700002)(186003)(316002)(38100700002)(8936002)(66946007)(66556008)(66476007)(54906003)(33656002)(6916009)(956004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tD3fY9YME0Rcfa1fcTcAaJDiln4IfuAYq5OIWf+bxqPxFDZJ0A9wJruAU1iT?=
 =?us-ascii?Q?DKERZUqLJ7jbRXhMpvbG8ZY4eOh1fuhZrSEzpdyv/lgOlHlqPsGRE8ttmSCD?=
 =?us-ascii?Q?FbMyFolVEuDjsBUrprLbePK7oNHI6fR1PM3WAUSRGfH7c0Z+Mz0ct7qdEkWB?=
 =?us-ascii?Q?Vea6SDcvwx2nlOok++lcECmntmutxDFm/II+QaVUlzcHEw4FwIBYXe8jUJhc?=
 =?us-ascii?Q?kxPSC3+la0LtVr15vpFoXYyWoz1oso463vQ9T6tF3KIrb/Wb00llE3O7qKD9?=
 =?us-ascii?Q?eF0/DaiXYH59yT4GiHSVbX3fnt7aUl7fdcK8vvoI1WNWidfKk7TKGtM2GmHF?=
 =?us-ascii?Q?Xz4KG3FgCOAI5z/kCNrro8YC0U1wyBE9RPdX/bVEHhYF7WfpTTzpcJ9POGHG?=
 =?us-ascii?Q?fTCiYAg4qYV7Nn+HcMm0e3j2aiYmO0xXygvLDe+XKoGnqzUsudvsuR2cIrQ3?=
 =?us-ascii?Q?MBhLPf8x8iX85LOnnmaraYtY9PNKt14XwuungbncBoUvAiRwOi0+N6hZ9DE9?=
 =?us-ascii?Q?G7A2PxQB2fjcg7/zNMAsHcyVw82WlzPRDceOU6iW2Dd6XPj/RDxhjL60EUXe?=
 =?us-ascii?Q?aeiHEqBuiXkdat7w6j4x7aXeMb68YwmamtZiLOUyE0/Hk+fNjJL2mDUK86n7?=
 =?us-ascii?Q?3u4DCPf3ZtOXqzxhB9oqMYgxmcXh1IZA/XtHssQRXduoHYBVX3TUeLHTvNC6?=
 =?us-ascii?Q?JFafW/HzIhsTVw3QUGmTalxnHEMXZmBHGYOdxq7ay0YHZ4hSrQdEu1VULzJQ?=
 =?us-ascii?Q?sFtqg4YRnu6s/KksNP29EUTpWah5pbNhaQcekr6y5PrWP1OqqqCTWzp8Wq56?=
 =?us-ascii?Q?0BYirgda1XtjQEV+jAN3DGhkUgCorrecx5cU18SDPUBjbf9OQfPX0XEzvZIo?=
 =?us-ascii?Q?svOEMjVdc3MYbZIBEuIRdbsfJAG5rRT4CTRTvJzOGZ0iMZY3Ifa8wbB2cNSa?=
 =?us-ascii?Q?L9TgPxg96qmo0/kHMggQ+SktVlANQ6AB9puuZzPO9qAj7TRK3F4VK0HJpVhR?=
 =?us-ascii?Q?UjGEjtC4Q1cwfovrIJvXkSUO6UQ0Ho5C/rE93+eGHmlmnH/5H6+4cTprrHww?=
 =?us-ascii?Q?7m3fnhJ+dl9O0Uu6PLiKjXMpnffxY61fz647vMHoYBtWyUppoe7wFkQdLmT+?=
 =?us-ascii?Q?naN4loCcLyqCL5f2BJ9C9nGMx+ja7yly51P9y9Jd6mQ6tSQpEvkiRYR3huGM?=
 =?us-ascii?Q?fHtRInmFJTH9DL8OZBSA2AcUnXCWmrIcwDayLJmFwdRVquk7y2RPnYeD3Gra?=
 =?us-ascii?Q?1KjuKRwPHD5kYM7jxzOneTpDRdZnzQ80N38FYjqgJM26q8+Ibmgif0TdfUbi?=
 =?us-ascii?Q?cl//zOkXw43JMcHpRDmOHmnI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cad826-b653-4c7c-34c5-08d915c8a280
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 04:36:11.5638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4xXj0wAkhIWtIAXTOxU+1+z5NR4lXDiKBhBPdffO+Z58ZPGl6YHu7gWcBd574LZ/RRgiBUn7un5IDxolzfPrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4573
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 12, 2021 at 04:53:21PM +0200, Ard Biesheuvel wrote:
> On Wed, 12 May 2021 at 15:19, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Apr 23, 2021 at 03:59:01PM +0000, Ashish Kalra wrote:
> > > From: Ashish Kalra <ashish.kalra@amd.com>
> > >
> > > Introduce a new AMD Memory Encryption GUID which is currently
> > > used for defining a new UEFI environment variable which indicates
> > > UEFI/OVMF support for the SEV live migration feature. This variable
> > > is setup when UEFI/OVMF detects host/hypervisor support for SEV
> > > live migration and later this variable is read by the kernel using
> > > EFI runtime services to verify if OVMF supports the live migration
> > > feature.
> > >
> > > Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> > > ---
> > >  include/linux/efi.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > > index 8710f5710c1d..e95c144d1d02 100644
> > > --- a/include/linux/efi.h
> > > +++ b/include/linux/efi.h
> > > @@ -360,6 +360,7 @@ void efi_native_runtime_setup(void);
> > >
> > >  /* OEM GUIDs */
> > >  #define DELLEMC_EFI_RCI2_TABLE_GUID          EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
> > > +#define MEM_ENCRYPT_GUID                     EFI_GUID(0x0cf29b71, 0x9e51, 0x433a,  0xa3, 0xb7, 0x81, 0xf3, 0xab, 0x16, 0xb8, 0x75)
> > >
> > >  typedef struct {
> > >       efi_guid_t guid;
> > > --
> >
> > When you apply this patch locally, you do:
> >
> > $ git log -p -1 | ./scripts/get_maintainer.pl
> > Ard Biesheuvel <ardb@kernel.org> (maintainer:EXTENSIBLE FIRMWARE INTERFACE (EFI))
> > linux-efi@vger.kernel.org (open list:EXTENSIBLE FIRMWARE INTERFACE (EFI))
> > linux-kernel@vger.kernel.org (open list)
> >
> > and this tells you that you need to CC EFI folks too.
> >
> > I've CCed linux-efi now - please make sure you use that script to CC the
> > relevant parties on patches, in the future.
> >
> 
> Thanks Boris.
> 
> You are adding this GUID to the 'OEM GUIDs' section, in which case I'd
> prefer the identifier to include which OEM.
> 
> Or alternatively, put it somewhere else, but in this case, putting
> something like AMD_SEV in the identifier would still help to make it
> more self-documenting.

I will add AMD_SEV in the identifier above.

Thanks,
Ashish

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8C23F7821
	for <lists+linux-efi@lfdr.de>; Wed, 25 Aug 2021 17:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241557AbhHYPTi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Aug 2021 11:19:38 -0400
Received: from mail-co1nam11on2043.outbound.protection.outlook.com ([40.107.220.43]:35726
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240918AbhHYPTf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Aug 2021 11:19:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MI9zaJqctj9DT/XvrDbFMDbJUXrY16+MkmFZHVW6hx137nC0mJpd8Z6mYI0Ti1kB4L1REY5N5/Taja9vkRJMFrqNRp25i7lN1tB098AHoc0FTQiKU4aOhDDwEQ2zDlsaiZCbjPti02F2SPoETSQ7YEohVSXJKlxqvXstECfOwA+l6nJUJ6hrJ0ZHihoXj2dKRgej8Xk/Hl3WcRlykzSRnr16K2V8egiAJTeTPIy8Xnslu8LZ831fbS0NpmsCxFuYKp0wr56rIUo8CQ58ZL390wMc3ZPPAMiuYCEsp3lIj2QkMBx4p+8HsOR1XGUW+MKfRd56gKGi0SxV81K40cxsCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sZKvX4kWKcQ6r52UHNwDUGtvKa+ygMYOy/WhDv2Fh4=;
 b=XVhd5UDYqlc81BoSDrLc9SAYTQpSJQYv8zu7i6XvT0CG9oONPomcpGJfKBXSQPpwF5aMF7FgVAwUoO3BMipAgTTR/OSpTSmVLUm8QEs9ZvpNCy3mMoBB+X/9k1HzMzN/Q6ToG6qszX4KlXT7CJXthYLy34Ue2QVnTIru5NHZvs3PG9lIdzIGE2R3vvigSqg9+YITRwU+kZMxDgUZYV/AaL2M1MilSGCkHca/xdq3eiwiewmZU8c4Sw9p1TlH+sVf2Wf0Yww8ukjI8Y3VjOpka0vJE8AwqVuxeVGpWs7OfVWSGwPkCZ+YfDS6ybAbo8Af7EsSM9C3EXfzunlxPrFzgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sZKvX4kWKcQ6r52UHNwDUGtvKa+ygMYOy/WhDv2Fh4=;
 b=UQdkKHQwgWmT6Mh4vXxK//9qnMpunzWHlgDnsHlRH8l8teFlvcQxSeSWovjv6kWtwUDp0aCd/C6ggz5owwOvq/H7Rv5X1PqQtDPU2rhCe2ednMU2mH1o3Lp6tr+A7d0zKYKzvQVZTZaVi2qA9w8ad6rb4NkgF1EIqGBBYp1OzyQ=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3878.namprd12.prod.outlook.com (2603:10b6:610:2a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 15:18:46 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0%8]) with mapi id 15.20.4436.019; Wed, 25 Aug 2021
 15:18:46 +0000
Date:   Wed, 25 Aug 2021 10:18:35 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 23/38] x86/head/64: set up a startup %gs for
 stack protector
Message-ID: <20210825151835.wzgabnl7rbrge3a2@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-24-brijesh.singh@amd.com>
 <YSZTubkROktMMSba@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSZTubkROktMMSba@zn.tnic>
X-ClientProxiedBy: SA0PR11CA0163.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::18) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (76.251.165.188) by SA0PR11CA0163.namprd11.prod.outlook.com (2603:10b6:806:1bb::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 25 Aug 2021 15:18:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fb37a8a-e7d9-407f-3799-08d967dba1b2
X-MS-TrafficTypeDiagnostic: CH2PR12MB3878:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3878FE20D7FA4C675F6CF6B595C69@CH2PR12MB3878.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Hyw+i4c5KbcugAWvKk3Q+40yq852DLKoZk+2jxLbxLdfJnTKGwgL3wehYwNC+F8qtB9t6XiRuFMJCTUB5J5nQmKIJ49y9S3CrjThEZNXHtMSva78GTUXUejiSpZOeU1Cq5fQ4iCCrWntPKUeokJphNHtJmIIrLr6ndLefS/gRpDiEiuJ024Q0jtL5MH+0D43xijye7DPgcmVCSEv/UbsIGP9W8xM4n2Ss8eDaZSiQJuAYjeV29RlgvhooCBfs5Q6+HqGp3Yrn2MsINU9QokzwsmmdVPS95YzbN5tu1gKNa51LZ2eRtDGVHL6Jzca50Yc1emDam1iowQsTiC2JrIhtMmIY0p1CoJgYvfNo/NoUTTjVSLM5IFJciwHQ8HO9SqJ9nk+tYDua6tQUhqAf0c6z86rgi5JuPrKasObpVn3MDAXdohszT0ojBPSCfV5daiP9xF97qO+BrCBOvzQ8shmTJEnx0OZ1MME2uQpdt0J6Cqw7a276ZKFRm2wvXM17RmEcR116cDkFvpwr0WujP3RkDs4AFmcVPVyaeoaEg9bc4LDKlnk2M9oj/I7aQJz60IisaL9eao6z4F5B/wVQr9HQ4F3gIAjvp04AQhQgMN+EyJLkEbnxg8lZZE5ST/VDJRaDEV5pIGJbr+zj8GYD+pYiz40B6wI03F/Yrm6zFsT9loo7Pr2rpfDFkYMva1Zw/x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(2616005)(66556008)(2906002)(4326008)(6916009)(44832011)(956004)(83380400001)(36756003)(6486002)(66946007)(66476007)(86362001)(6666004)(54906003)(316002)(26005)(5660300002)(8936002)(1076003)(52116002)(38100700002)(38350700002)(6496006)(8676002)(478600001)(186003)(7416002)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fr1ohqs5z2Qzy04libSMiGmzF+rqBzYDLvRdwQg3objTtRnjGCz0vuDnI+LO?=
 =?us-ascii?Q?AZxS1MEBDmh6tKDj/IzgGRhvf9HL05fofsrzyykofdYw7fQmY6MIU/ei1+I2?=
 =?us-ascii?Q?Ro7c5QlgwKrBtwmo/3boYCJ32u4Dee3aSToKI5z6AyBNXe5IrnynNXGmCL+n?=
 =?us-ascii?Q?j/FJ5vQG5msnJ4aCsCGaTuqf6yP0QS9o+URSDuC3UTYrcaTfLCsdJVuvs9W2?=
 =?us-ascii?Q?wF1xUki7u2fowlPF5UW8g/ffmoQWEksq3xn8ySBJnES/cRbFt2rDgKfGTbno?=
 =?us-ascii?Q?iG/3OLIVZCg3KypyaDD2jGyygi3NJ2j6Tv7tICyuTJpgQMhLy9/YrduAYEnu?=
 =?us-ascii?Q?K59KjWN1qvMBJLlpWP7d3ZWFJa8roWuytuKvzyHnyDZVAzmxzXo3JpJ7pBYs?=
 =?us-ascii?Q?8sgBRtLuivX8GSwg4PxVY7sigdT7UdtbY1lTO6cob3hCHIgW8WOnN0dy0O4p?=
 =?us-ascii?Q?F0CafVz+jnIVsVJz5QoTsLZzAHD+oz2Fy2hU6M51YP7i0MZSWqDHYfFrsuTo?=
 =?us-ascii?Q?6+6hFATlaoGrU38h0YjvCOhOoW7gK7KSSOpa71tP0lZ5ydj2xQcFiJHZsOAK?=
 =?us-ascii?Q?k717T6qjpH+sY6ObSES1bXcj0honWGPJWG8jZPQH093J1wGU2q5drKwr2AFK?=
 =?us-ascii?Q?b2fcX6uxEC5+aqJSx13Ncnf+bS0KJlP4tljBLo7F8OKRWu4jr9TRW34zZoQF?=
 =?us-ascii?Q?SLE8Mjc312FBhktj1tyHYo/uWkuirvasWBQMvCv2melhuOHTTubfOmsMfaUh?=
 =?us-ascii?Q?qBjt1X4/LnXZbQUPvS9YHfG08QKmDCMNI+Y4pUTqeKqQdzYOnUYPkJJVczLI?=
 =?us-ascii?Q?a9l5nXTS50rOejkGj0z9l3DEpa16S6GcuSXktAg9FWbcyWnaMnB6bd8/n1kP?=
 =?us-ascii?Q?oqktgpVde+3M2HO5b2WDrPBQcl8ki/k5zCzV42PPz5UbugWwNiaUbshUZZbz?=
 =?us-ascii?Q?/Xlg+oqR9CH57Y8CbV7kEqp8n3v58K+9opVe70dEKnYs2ekpx+ME8ZyKgEYe?=
 =?us-ascii?Q?uPOd6A3xcq1yqjU3TjsK02K+uq1cFSt09+4sgh39vW9HXFJXSkHUJ6vIvYN2?=
 =?us-ascii?Q?FQgFfRmsbIH1SGwJMFtrr79jGD+sMsah9OMMX8Wl7hkES8lh5IsbcsSwjpOx?=
 =?us-ascii?Q?JMRhX19fYm/r4l6uME+kHIReLuVuPyqtAKYBxT1cHIuXMIw+MbwdFXkEqi/E?=
 =?us-ascii?Q?UyvA81qTgMJ3Hym1F7HlrAElwKOVH16j0d0DmD9zrYyLFBZw7oUzU8MbKxRw?=
 =?us-ascii?Q?C/HyB5jNItbeyxE7vL2V+W9q4xEUtokhGqs/IpWh/5tMI5takIwROz5x8O8H?=
 =?us-ascii?Q?5+pEbq6NsS7uXupwnHF5/jRz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb37a8a-e7d9-407f-3799-08d967dba1b2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 15:18:46.0216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojff3LW/fTu8/eZW+JAIFFbDFJ87oksWvi1ATRy835GWHAC516GymBhSG9wlobGKdZBQupu3978/eJNNvMaOlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3878
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 25, 2021 at 04:29:13PM +0200, Borislav Petkov wrote:
> On Fri, Aug 20, 2021 at 10:19:18AM -0500, Brijesh Singh wrote:
> > From: Michael Roth <michael.roth@amd.com>
> > 
> > As of commit 103a4908ad4d ("x86/head/64: Disable stack protection for
> > head$(BITS).o") kernel/head64.c is compiled with -fno-stack-protector
> > to allow a call to set_bringup_idt_handler(), which would otherwise
> > have stack protection enabled with CONFIG_STACKPROTECTOR_STRONG. While
> > sufficient for that case, this will still cause issues if we attempt to
> > call out to any external functions that were compiled with stack
> > protection enabled that in-turn make stack-protected calls, or if the
> > exception handlers set up by set_bringup_idt_handler() make calls to
> > stack-protected functions.
> > 
> > Subsequent patches for SEV-SNP CPUID validation support will introduce
> > both such cases. Attempting to disable stack protection for everything
> > in scope to address that is prohibitive since much of the code, like
> > SEV-ES #VC handler, is shared code that remains in use after boot and
> > could benefit from having stack protection enabled. Attempting to inline
> > calls is brittle and can quickly balloon out to library/helper code
> > where that's not really an option.
> > 
> > Instead, set up %gs to point a buffer that stack protector can use for
> > canary values when needed.
> > 
> > In doing so, it's likely we can stop using -no-stack-protector for
> > head64.c, but that hasn't been tested yet, and head32.c would need a
> > similar solution to be safe, so that is left as a potential follow-up.
> 
> That...

Argh! I had this fixed up but I think it got clobbered in the patch
shuffle. I'll make sure to fix this, and remember to actually test
without CONFIG_STACKPTROTECTOR this time. Sorry for the screw-up.

> 
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > ---
> >  arch/x86/kernel/Makefile |  2 +-
> >  arch/x86/kernel/head64.c | 20 ++++++++++++++++++++
> >  2 files changed, 21 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> > index 3e625c61f008..5abdfd0dbbc3 100644
> > --- a/arch/x86/kernel/Makefile
> > +++ b/arch/x86/kernel/Makefile
> > @@ -46,7 +46,7 @@ endif
> >  # non-deterministic coverage.
> >  KCOV_INSTRUMENT		:= n
> >  
> > -CFLAGS_head$(BITS).o	+= -fno-stack-protector
> > +CFLAGS_head32.o		+= -fno-stack-protector
> 
> ... and that needs to be taken care of too.

I didn't realize the the 32-bit path was something you were suggesting
to have added in this patch, but I'll take a look at that as well.

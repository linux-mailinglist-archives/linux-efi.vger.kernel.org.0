Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADA43FD08B
	for <lists+linux-efi@lfdr.de>; Wed,  1 Sep 2021 03:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241489AbhIABEi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Aug 2021 21:04:38 -0400
Received: from mail-dm6nam11on2051.outbound.protection.outlook.com ([40.107.223.51]:56257
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234036AbhIABEh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 31 Aug 2021 21:04:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihmWJl9+BCCyGitoSdNxFxo+h9poNrdKKltuBgbgt4HJdRa7DNMB3CRxLwTN8yNk1Yr8ejcgLGPJ5T8Ve5IZpSSmFzzzsc6hsw/faCWrVuYFWAYwA2XhyADATTa6/RJRcK/d2xB7r4JJ6nTlz95O7s7NQ0maVPutOvJRyCQyTp2/Z++/YPWX9fu78/biu0lOfujlf3BIeFn8iUuAOpSO3NmFzTQvQk6YZOZ5DXvU6We4XYFTy62EURv4R+KQd6mAsZ/ee2U6URrSJqDUnsQYo97xPUnTLmG8TfyRsxfRr+SSObu/oYAB3SOzOuvZ0PGA5UOx+Xt28vdM80tgxbzj1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiQOQ6+MQDPiblA4upx6r2xhJiLv53K8dFchklvnFHA=;
 b=Jx1njChgYow5lvanSkAvVNAmVK3ipiE8ooYwuO9DbaMZ+NmPnXKlXNbePWTTItMDUVuxGxVvb0h/dnIZeq1Y81RSlZM966Xi1P1HiFVDhp+SeKWoT+uBM2XR4LeUZP8XQ0Mz1vuG8r1JkrW//iX+4NgZxSu42XR2D4/yGqQU5oMHTAcw3DniQ1KNUkN/Z1aUsE8TQHw1tpFt16p8FBJd/5K0elg83GlxBXrRLV8X+2evq+9QJtrY7LIfmHSisfsuUMPWcyI9H3oWGTSzxbOV8qp1Fy85K0csvZ7fFadfmScDF6g/nLbFeHldH8yokrS3T4WOZN6+JuH2NK5A03TXEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiQOQ6+MQDPiblA4upx6r2xhJiLv53K8dFchklvnFHA=;
 b=Uu7cWHhsSdXZCw0WnkyDgyOgMOuC1niejAEBRDorKeCc9+AJNqQx649EJnYxjRYswioyBRLh4TIQBThC9vgzyjvcTo/g9iEeNDHiaV28wsypC8O0ZyrHUKTlRFb0xS0a6KNtWnJR36QZ9fxpF1C7WdTjRJsbfsiRKJlUmAIIUW8=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Wed, 1 Sep
 2021 01:03:39 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f5af:373a:5a75:c353]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f5af:373a:5a75:c353%6]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 01:03:39 +0000
Date:   Tue, 31 Aug 2021 18:30:35 -0500
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
Message-ID: <20210831233035.fwvlc5au4ip5odsp@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-24-brijesh.singh@amd.com>
 <YSZTubkROktMMSba@zn.tnic>
 <20210825151835.wzgabnl7rbrge3a2@amd.com>
 <YSZv632kJKPzpayk@zn.tnic>
 <20210827133831.xfdw7z55q6ixpgjg@amd.com>
 <YS3iCqSY2vEmmkQ+@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS3iCqSY2vEmmkQ+@zn.tnic>
X-ClientProxiedBy: SA9PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:806:22::26) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.1) by SA9PR13CA0051.namprd13.prod.outlook.com (2603:10b6:806:22::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.14 via Frontend Transport; Wed, 1 Sep 2021 01:03:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11bcdc02-28a9-4cbb-474f-08d96ce4556c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4134:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB41343AD7DD22DCE5C7B05D2B95CD9@CH2PR12MB4134.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nt3NbTeVN6pTn9X45Jzqw9fCIxQCPrS+z/aQHPYjEunzzfhQCwLjh/yO4OKAZMDCP2M1l8ssqI2HnULmgSTFaj7KTBNcPOUFX2q7O0hbkf0EJ9ELKxdtz3bO5Xmb4SDPV0FzaA90um4ZBy42dXANdpMVFLjwu5O9/FeB11YNuG6JcmWQerxHgm0dIUb26MR9kzr2CCLxtCbWzg8WdUYSf2BM7WpwviJmBCXHuW6Uic1BHgh8wTwMrCuzU7ya88pP7oJErGhyoNXA6Jj9T2UD/+bioRsstmgiqFXnUDfzVb2tqUqHmKE0KfSZW00rtX5bNk0TpfS5ooJ/JdWhnrAFiTN/mi8rz6YvWUmEYTCzt/7eJouLR+0rEpIbGh0q/TUWO60QsKyJOVkKSUuxUVVf/jlQicli2QXePW9ipTzN8qmgDr/okfOvvvUUedefAb9U+RJm35a7vDAfEHI6UlyAA0lQsbtE9UjwLsYNAJb50qMPrmoT0YUjcKdSIBPA6uoVPGObB2mi+7viiH5BGzx1L0nyr8HT7OUY+pzcfp95LP4BhTbaQqucrKUpd8u8vEMzie3Um2hT9v2v+yQygOLiJ2MgbJX6d/+SbiRvnJwOrxV4ZdTP+AxSgFGWkHmS4GIc/BR+sWxEneLjNWixsIbcQi/5/w6LhtKW7+tF3uYs06MVMczUzvKkWSck35baIfAa7Zmx4heg5NDPXBC7PJsqNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39850400004)(346002)(366004)(396003)(38100700002)(38350700002)(7416002)(1076003)(4326008)(7406005)(956004)(83380400001)(478600001)(6666004)(2906002)(26005)(86362001)(5660300002)(6486002)(2616005)(66946007)(52116002)(186003)(36756003)(54906003)(66476007)(66556008)(8936002)(6496006)(8676002)(316002)(6916009)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N4XfEmUFSrVpKrcjvj/5KIBNIWZeVYmmebnwiVb0/POrvEHHxa4GIZgH/qzP?=
 =?us-ascii?Q?4qC9DYvXWte6FpICbafMNlk8+PuOdSga87Ulrt2EXkTHSRkJm70bHIVHVhuW?=
 =?us-ascii?Q?kYuSMS8Dx55+P8f7Rvx5qhMFD5bURWokz/IuJdqzSBdh1C/VsDFKLOgRUo8s?=
 =?us-ascii?Q?uV+iclMvuli6qUY3d554xU4IKfJSFBgZV7i99ARzbUI247RGLKbhR+KFrI93?=
 =?us-ascii?Q?Kh250P8FWtpDmtOSblAGPO24Tnec8LVETbkljzL1/1gDzY30IidDcp+8cybT?=
 =?us-ascii?Q?MKSXb/BFoBl2b+jEzZZUEBinGCwHtFx0afeyQ6wniLMi1ogWG6midAX4BcMX?=
 =?us-ascii?Q?+h4bAPNUlDNezVImHHkNZ1AHTAb64rW0meLDGYKxcOO5/qwxNwbu8Lx+pk2T?=
 =?us-ascii?Q?QBVziYk+PjlJWlE7cABtge4ztRDIg0PmATYUFJ0GUoOPpQepS9UfMSJ7P4rG?=
 =?us-ascii?Q?F0thoGBBbDMZehNyh+wP/PO4gOiuR1NGLmypgQwBal/aVPW9+J2D6cyCJflo?=
 =?us-ascii?Q?QtX0IpCMdicStxLpzRY8s0E4vDT3jDO3/Osgx1ydi9M/K0B1WpTLrD7N6kxK?=
 =?us-ascii?Q?U0b/6K6jIr2T0vxZLb7YlmuWSWqOerESapBoZoh86moYEUzUy3hPBaOlizsE?=
 =?us-ascii?Q?EOFUxP4/zZu2qoQNLNgiMTaIVUgQYixRgP8cHtPE7ybkekkzWEV8FCw+GX85?=
 =?us-ascii?Q?VMsxaqiG5L6iHa9jGXKTzEsJ7RJFI34EpmkaO4HRYGV8lO0uEKHkhHkJYJ0P?=
 =?us-ascii?Q?kEIE6P0UTqwFAiUcKvwh1sQD1Ev1OCqrqE9CEQaFLSQcl0kRbRsufl0Md8pq?=
 =?us-ascii?Q?cZ/C21gUEbbBty794lZSAvuWe9b9mmdq7NU9oXKvnK7KFASY6zJHNcpEFRXw?=
 =?us-ascii?Q?sSYkF03/WWQXsL/HCWFCht0CnQeKKxjiAOAdYiD8ahWfH5MHRAsjzsI+Hdd3?=
 =?us-ascii?Q?5sf6ZVzhU6LkAjH24o19dxCQ3BR9r/B+DcPLw70tnwGfRrsVgYc1eXb903lo?=
 =?us-ascii?Q?uQ44S5hPru6hKQldcvtFIvPOPou9eVwNsSsRRERFJvrepOjrJ5dQVrQqy9vr?=
 =?us-ascii?Q?lG7mE9ZSl4ie5NZU7Jy4B1jwRfvqEv88GwBP7jAFu0XX3H4dy4b3E6d50teu?=
 =?us-ascii?Q?8oRX4jiDyXIkTsHZrkDwdagXrYOe/VkZj+k2F5i2Y0fC+gP+8KEbrYA15hfT?=
 =?us-ascii?Q?itwSmbJFN2Wd7dJ1L2pW0iKOYjFKLhtovtnYxrh6pG3QuyqW8joEDMWAkduC?=
 =?us-ascii?Q?gvVno8zi8Deod15GW/f0Rs7mHri05Q232E3L5wpRmD9dyRvFZ/lPPp1FZtYU?=
 =?us-ascii?Q?9PF7D9u/cdul0X3pfCb82cCG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bcdc02-28a9-4cbb-474f-08d96ce4556c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 01:03:39.3597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8vG/KKzpPjwaUYetp8sk4TDe9owBXmsEVvDpQLu2iTYhTe7Mp9QrhOvJSfuT++VzEPIKaQ24lg5NJLYwY4JMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 31, 2021 at 10:03:12AM +0200, Borislav Petkov wrote:
> On Fri, Aug 27, 2021 at 08:38:31AM -0500, Michael Roth wrote:
> > I've been periodically revising/rewording my comments since I saw you're
> > original comments to Brijesh a few versions back, but it's how I normally
> > talk when discussing code with people so it keeps managing to sneak back in.
> 
> Oh sure, happens to me too and I know it is hard to keep out but when
> you start doing git archeology and start going through old commit
> messages, wondering why stuff was done the way it is sitting there,
> you'd be very grateful if someone actually took the time to write up the
> "why" properly. Why was it done this way, what the constraints were,
> yadda yadda.
> 
> And when you see a "we" there, you sometimes wonder, who's "we"? Was it
> the party who submitted the code, was it the person who's submitting the
> code but talking with the generic voice of a programmer who means "we"
> the community writing the kernel, etc.
> 
> So yes, it is ambiguous and it probably wasn't a big deal at all when
> the people writing the kernel all knew each other back then but that
> long ain't the case anymore. So we (see, snuck in on me too :)) ... so
> maintainers need to pay attention to those things now too.
> 
> Oh look, the last "we" above meant "maintainers".
> 
> I believe that should explain with a greater detail what I mean.
> 
> :-)

Thanks for the explanation, makes perfect sense. Just need to get my brain
on the same page. :)

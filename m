Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837D4434567
	for <lists+linux-efi@lfdr.de>; Wed, 20 Oct 2021 08:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhJTGt4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Oct 2021 02:49:56 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:49041 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229771AbhJTGty (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Oct 2021 02:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1634712459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3l/yL/jL8YLAVIa+AiGT9KXFbB/hSR9Ga0vhXKCP9bw=;
        b=VGE4+z8vqOK88Qdw3ls3N/D7x7HIsG/aXNI+RqQ6ocKOEaxov801cbAJl522eygYLAFyoy
        92SkXKHK4MXu6lgu6IYZWV2Nq+og1V3o6NZI7SGFWti05QQyONFRtq7HmldS3zM9gEJ6BL
        8bTAXi217CKpVb51qmiGxYFcAsmlDHI=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2055.outbound.protection.outlook.com [104.47.6.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-37-duINYTErP4itPt3d7N05mQ-1; Wed, 20 Oct 2021 08:47:38 +0200
X-MC-Unique: duINYTErP4itPt3d7N05mQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUCGyfx9ISUyAzWS0R5VwZ/E8VOk1wM04vhsdxKQl4UHxQRQg/iTOIDiqvSxd6qVY/t240soJKSYL3iIqAyakS6xI7sFFWnUw79LP6IFjHRrUkOjNAcu7zZBOVuX25BmLPf3GUVY4yWGTRphGeu2AOmcPVGHDA4PMQfOgo/nT1GSDcNrbqSFIm31C+3Gpo3r3sUVFXDXMdR+pNIA5nu1gjrHzi3FiMapOmTGu8mv/rl0kMzca916o5kItB0SbXymNZIg833Gba5OVEvRYf2NTPBfUzftQPp5Oms8Sbu/m0Zy1fv4pc+GJHLkxEuvu+VMwaz/ESFS7dxUS0d3f24gFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3l/yL/jL8YLAVIa+AiGT9KXFbB/hSR9Ga0vhXKCP9bw=;
 b=IckkbKX8fFIpqJRG1xmpbEefU4lKIp98fFjvIXTILtNjcVuNW23jTKB/eASOkkBNiUhzcmnh4hOq9lcOcP1zx0mH+E3eGGP7D3ArB0QjlkbQGdCbs6JiTfLhnYobjg01ulvwQdHx1UkyUSUvM5tF4YvTFnnddBoph+kVKSy4TICoChHIYg9d1nja25fHUIYpCbgtBhyUgjFZwx0wkgJa0/CT2n3ovWLCbeKnETpUmhQ+uLc4Htfj1sl8JWdrNtVRU/Q8fnRCOJ7WIYtj428o+PAzZxVTlWgz0UlSdKBXiDzapoZVfi1PgAkmekn+mOzeQJzLvaOkN35ZY8Bxu72Y3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com (2603:10a6:800:124::12)
 by VI1PR0402MB3870.eurprd04.prod.outlook.com (2603:10a6:803:21::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 20 Oct
 2021 06:47:37 +0000
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::8876:23a4:2391:2ea2]) by VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::8876:23a4:2391:2ea2%5]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 06:47:37 +0000
Date:   Wed, 20 Oct 2021 14:47:18 +0800
From:   joeyli <jlee@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] efi: Disable runtime services on RT
Message-ID: <20211020064718.GD3965@linux-l9pv.suse>
References: <20210924134919.1913476-1-bigeasy@linutronix.de>
 <20210924134919.1913476-2-bigeasy@linutronix.de>
 <CAMj1kXFJm-su9tc20n+DyJjMwrhK6R4BR0Kd_ov62NqXd-jwUw@mail.gmail.com>
 <20210928133340.tmpjzdj367h54ddt@linutronix.de>
 <CAMj1kXG5-i5LqnQrjK79KWZYTPO4C4fF32KhQexj8WsHLQM_Lg@mail.gmail.com>
 <20210928142434.uqhkd3ribja6j654@linutronix.de>
 <20211020060955.GC3965@linux-l9pv.suse>
 <20211020062850.3wvw7lqauh6pzfd2@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020062850.3wvw7lqauh6pzfd2@linutronix.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: HKAPR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:203:c8::17) To VI1PR04MB7102.eurprd04.prod.outlook.com
 (2603:10a6:800:124::12)
MIME-Version: 1.0
Received: from linux-l9pv.suse (124.11.22.254) by HKAPR03CA0012.apcprd03.prod.outlook.com (2603:1096:203:c8::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.13 via Frontend Transport; Wed, 20 Oct 2021 06:47:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 806fa2b2-5078-4672-fec4-08d9939580cf
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3870:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3870D544842CF08719F83678A3BE9@VI1PR0402MB3870.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Resv1F3HDtAgIEjTGuqfbX3IKJS15zjv+xXC+4fMtXCtLTI7YyIcRiZpcsqNOJcWklGbjV26tmtS+AR8qMqw8th/TLztUlPoWc+9RphW7GRuSihzfixML2BRRa4p/PweeSQXdoH6M1VtPaJCvx96SH2KOnd4IO0VOABK5CbeagqOOMQwKK/pxcOS89SkI2PVikjJHr5KYBZ8YXDYrDJTc3LcNvqnSiLbGvOWEo02ngw8jGtyLKgELXzcDl/wJPZI3V0nIa2ZJu0okfbjv0uDa5hn4uWFpOHLL1l/jvgUk4+Fq3cHtZVB1NzY23PyPNqULzTYnwgnR5FOigjphPjhnIOlDicEDnGK5kWiuZgXlS0b/8vsz6ZcLbXtw3yJ7SbjDOahgoRZ9/OVThsP+tffOwlZDiNEYbSNgir3QbDSRIcIuJ6LlXo/phStBr2VksPBDqVQLZl/N6KGPN7Wio6Kjr1tubbdB2fSil+F1PJGPvuAT/SSsauVchPzmxtMmxEIZRyOBvTbM3ph+MS0Er/7GPAhr78ox3HFGCKH6uX64WchaJ0Cx0ks4BGE1lud6TAsBKmbxVbiKca6UhO4lyfn5Zca7/JGtIk/hjjQ6xaPC5YIMwmVnpjbE7anFY8yU8ghnyLquybcT9uGYNcrhlTR0sUA2BcLeJnucH0ReF3i+XQfM2prBYanhJV9jDwRWcYeq2rYywBTfUNsrvS6T2f44Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7102.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(5660300002)(83380400001)(8676002)(6916009)(508600001)(54906003)(186003)(55016002)(8936002)(1076003)(26005)(6506007)(4326008)(86362001)(66556008)(2906002)(4001150100001)(956004)(316002)(66946007)(38100700002)(36756003)(7696005)(53546011)(9686003)(6666004)(8886007)(66476007)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?84W4DVXZgM46mEL5GiQe+yuy85mUhErEweVckfQHyN/uJL71fKdShtK/x90r?=
 =?us-ascii?Q?vm98mcbc00FsXgBFswl8SVaz1NFg4rSp88xEMC//X/O+4KJhvH7eOLWjM2EM?=
 =?us-ascii?Q?S7+pnNo/zzdUR+MkxL9MlalynNb6z4E+zpc8M7qZLBSHXsDMyrQ2o1tDca0e?=
 =?us-ascii?Q?0Jtd/YkecZY9oGI6oj0dCwlB7Wfn/e8+axhJIZMMs4sQRy3KfCJvvSehw5wN?=
 =?us-ascii?Q?x1jj/ufbC7OQxzGCt75t5phHDo/bYDzQaaQMYyW7Oh3oHeh/We5aWBZQ4HFh?=
 =?us-ascii?Q?GO0rKtEMO5TciELX3xuve1BnfoKiqy+CwpmiVa9rkGCT6XZ78g7anD/eHTcf?=
 =?us-ascii?Q?0qvszzhJLJccGDNIgyml7Wh5iDjyFcxL6++jM5YT4uoachZSrkJAZvdwwgX6?=
 =?us-ascii?Q?/GuuV11PY2S9Z7SDZA8mBGL9YKbK8hSwpFgr1m50a8sTHnwqqMKXBZKsDd4G?=
 =?us-ascii?Q?Ws9TzfNM0bvUfhjq0/kmmcC6QPOzoV0ZvOv0w/NhLWjUWKaSFOMfH8jKrVw0?=
 =?us-ascii?Q?W2GnJXI2QRan3ndIZcwx7fI7ylTn5wvFNtncK9f2p8ZjicmzOZ0R4SXQVUBT?=
 =?us-ascii?Q?4nKuqo2JlusuR2Vs40fJQ5w5sb6DjXmM5gaWX2jugFOuUdw0kuF6VsmlOaTA?=
 =?us-ascii?Q?TM1QWAs9duu9H6MIwgpkAqtaNFIS3EY94oXV/Q66yGRNt/6+olnDaE/hAeBU?=
 =?us-ascii?Q?npglAV1HjgHIDmECbiUIo394erDgtZQXyiAgtbQELL6tXDbVy99VkPPcvKPF?=
 =?us-ascii?Q?yT2zU3dWTQBuArL6NOrlbaTXEIbc2Wz6XjQcuBxWIWeCWup1Z7vMoErxtt97?=
 =?us-ascii?Q?r9z85/6ntrI+c1hQmUSFHLsRpf31bWFN2G8U9McUdxLtjZND4OMqKW1qsS0/?=
 =?us-ascii?Q?IMBAPawBSTRmv+JzgLEfG/PiIoW5sfslUfRTs4PvnRVVPpdPUMiTub2Yp8Sa?=
 =?us-ascii?Q?XEAZFtcIM5av+fsckFu+MKHVPKo69jjDfY7xkO3n8apfYpnukFFF2hSrfMPT?=
 =?us-ascii?Q?kCzMSyQdIGLb6uUA+bbf8Qz7lQeoW6JkgvgVs9UkwvV7ZSx+EB1zwwXoNxAm?=
 =?us-ascii?Q?BC9mre16vuW5VrylEGCrB0TnZSzeDlWYp55k0tjBEGOfErXHGFyVB39OvyAo?=
 =?us-ascii?Q?5mgs9jB/bpvn7y5KmOgsaW1XdiQUBNr0Sru0d/C+o+LIcK6CN/jF313Tq4/G?=
 =?us-ascii?Q?/K0kMdvUl9V3OkEhLTgvX6+9cwIey4I8gRwUIwPKuocuR8LeK1BB0rDkwz7D?=
 =?us-ascii?Q?hsnfT2Ttd14T114Ub6zjbiGmfuO06RqXr5CdFCWSk/ChKmDteUd1qrggKbT+?=
 =?us-ascii?Q?uPJQ5FFgOZjsM7vm6HfW2oGQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806fa2b2-5078-4672-fec4-08d9939580cf
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7102.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 06:47:37.1096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72GDsCN05UG9q/1FaAsYtZ1YvhTduqkVo+SCJVM2y9nftVURGG/uCZKqIq7sywjc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3870
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 20, 2021 at 08:28:50AM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-10-20 14:09:55 [+0800], joeyli wrote:
> > On Tue, Sep 28, 2021 at 04:24:34PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2021-09-28 15:34:47 [+0200], Ard Biesheuvel wrote:
> > > > Are you sure you want to disable EFI runtime services on all x86
> > > > systems with PREEMPT_RT as well?
> > > 
> > > The only problem that I am aware of is that you need to reboot with
> > > enabled runtime service (via bootargs, #2) in order to alter boot loader
> > > settings.
> > 
> > Just provide another case:
> > Anyone who uses mokutil for enrolling MOK will also need reboot with
> > efi=runtime first.
> 
> I have no idea what it does. This enrolling is only required once
> per-lifetime and not on each system boot, right?

Yes, no each system boot.

But when boot loader or kernel be updated or user wants to install a
self-signed kernel or module. Then they need to reboot with efi=runtime
in the future.

On the other hand, any RT distro that suppors MOK needs to modify their
installation program/process to add efi=runtime in first boot. Otherwise
the installation will be failed. Honestly this patch changed the kernel
behavior and it may causes that old installation get problem.

Joey Lee


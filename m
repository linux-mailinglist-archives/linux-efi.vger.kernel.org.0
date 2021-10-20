Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2884344F4
	for <lists+linux-efi@lfdr.de>; Wed, 20 Oct 2021 08:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhJTGMY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Oct 2021 02:12:24 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:33439 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229809AbhJTGMY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Oct 2021 02:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1634710208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VJ5x34pCZ2oWPeZKzURtBbFrgaBuDw67byHsKfbkycE=;
        b=UhbhSKfLYPCX8nZMznVJ2+Pkv3cYiCyppiGMcZ7SH+1LU2JXDuLRr+B6GOGRmFA5uhUTkF
        ekKs1mo+mynsrKfy2kCfAq9yhG7C/rkUkboe6HiWO9ZDznNtAMw+VNxRocdeXY20855w/C
        wpYZRrgvzlbIHv0mI9Tm0dN+JNC2BBw=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-21-X3LGlpeFO_K0JH-PLbAigw-2; Wed, 20 Oct 2021 08:10:07 +0200
X-MC-Unique: X3LGlpeFO_K0JH-PLbAigw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmMNNBvSbUim+WvakLBJ/xrAEb2x3GaCeuckD9enwX+ioftIx/YJMXApDgYRvG+tDgmKck/ePaBzd+x3tNFImKRp0ux+o+q6DtXUC4P+yuE0namnkZp8q5lXFvsp30Ckl+wiE7tRTl+nDfwFVPCO3syigCD9wq3KnLPAwkyoAV2OIU81YXlvRgqlFTBgiImUdY7zC2to/+QUMJfpjJ50cRmqxOOEEV43rAXbRdL1gZJbcPoMXS40jCmgoKKl1S+mhIAid/PEOq+LGja3fOIbAnt7lM3Li2hLM1cUx7EH/H1sE7N28wCsjETg9Xk3WuWAFzF96H/Dd+TU7J0Q3BlMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJ5x34pCZ2oWPeZKzURtBbFrgaBuDw67byHsKfbkycE=;
 b=aSOTTs3IxDAy+Pp+XXiblOmzGdl3Vw2/5Z/+R6f5/zbJoxGendAi8kqixtYFK0nHIKEqdTmvDe+lW3JGZwVGZutss5yIJhGrB99V8KhlcD6jrsZ9WGCN6o0HiqXjn2ojCFb3INMejlgCCPWlnMWIj1MCHrnCMzZcLHyNej9gBdivamJvRjMUyqeR/ZQrBQrSOYCxziI0w1buX7o6HkpyJOVQxuO9iAJ7UZYA3KKue3ArseOStBGIi1MAHAqDmh6oGNdDLn8tSZo1idLKFr3JQMnVrqw7vFQelbh23D6gMBe9awYpERhnQUMnqUQTL3haCj92SiimeBMdGr8KVQAOrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com (2603:10a6:800:124::12)
 by VI1PR04MB7103.eurprd04.prod.outlook.com (2603:10a6:800:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 06:10:06 +0000
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::8876:23a4:2391:2ea2]) by VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::8876:23a4:2391:2ea2%5]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 06:10:06 +0000
Date:   Wed, 20 Oct 2021 14:09:55 +0800
From:   joeyli <jlee@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] efi: Disable runtime services on RT
Message-ID: <20211020060955.GC3965@linux-l9pv.suse>
References: <20210924134919.1913476-1-bigeasy@linutronix.de>
 <20210924134919.1913476-2-bigeasy@linutronix.de>
 <CAMj1kXFJm-su9tc20n+DyJjMwrhK6R4BR0Kd_ov62NqXd-jwUw@mail.gmail.com>
 <20210928133340.tmpjzdj367h54ddt@linutronix.de>
 <CAMj1kXG5-i5LqnQrjK79KWZYTPO4C4fF32KhQexj8WsHLQM_Lg@mail.gmail.com>
 <20210928142434.uqhkd3ribja6j654@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928142434.uqhkd3ribja6j654@linutronix.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: HKAPR03CA0030.apcprd03.prod.outlook.com
 (2603:1096:203:c9::17) To VI1PR04MB7102.eurprd04.prod.outlook.com
 (2603:10a6:800:124::12)
MIME-Version: 1.0
Received: from linux-l9pv.suse (124.11.22.254) by HKAPR03CA0030.apcprd03.prod.outlook.com (2603:1096:203:c9::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.13 via Frontend Transport; Wed, 20 Oct 2021 06:10:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fa0ce80-111a-4d33-01c4-08d99390431d
X-MS-TrafficTypeDiagnostic: VI1PR04MB7103:
X-Microsoft-Antispam-PRVS: <VI1PR04MB7103662552CB52E6892F94BAA3BE9@VI1PR04MB7103.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMX41ttwcn7SKuYwpIKUixp9my1uIKov0SpxJE+fdC4MdfPsOTd6SAVbTjHeJQ6jxNDosuIEuL8vu43QntNC9M5jaZ5LMjfWNIbDT+IcrSfsbWvS2uTWJdkKBXEIcPUc8oMFUo38CMN6SMoc6a/wGg/xWJ3NvQ7FVhTjJtp2kw9udgIzPM+s/M7BGjbMy9XkFRhPrR2xrdDZCERy0OrhbeGU9cdGALfdAH4dyuYSO4OqIfD1CZa9XsQNFvR5GNaALOmO0vUCbjnMFNHhP/F4xD2bKffUolJrzyjQy5iECfEkTv58/Fkc6oupqwc3VRliNgh4BVxydTsgwW5x1JUBdajpvyXb8AObic+umR8Ihq8NRiuHYNDwNn20S9rhszIyOkuZqW72tW+IQ0OB6D7apmhYIWlb3NtJAUYKR5e5PNMKbj/F9I7FQ+LY90hqePdet7CmfNWQU61/9c0ddqxECbK32KhLCz6t1GZu34/hzZEvqzrMyqg9dH1xgtTCp1260hofOlzaVg/pHwLf36BIu9AEginy896X0u7EBp8N30oJfUNHKwzIE2IHs/4seTqyzEIHWAEsN/TRi3KLN7O6BlZTAtuSAmLZdoIqaV9nfcqgKFPUNdc3N6dpRhdWyTdu935n0EqBiEqGcibwNx5tJCnVL0rGb6A/1p7VFRNyH5hUJyo2moZKgVcfKN3V6RUj3h8yL+2uwfkZzr4nO/vMYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7102.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(956004)(186003)(8886007)(9686003)(38100700002)(6666004)(55016002)(8936002)(316002)(26005)(36756003)(2906002)(86362001)(1076003)(6506007)(4326008)(33656002)(53546011)(66946007)(7696005)(83380400001)(508600001)(8676002)(66556008)(4744005)(5660300002)(6916009)(66476007)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WA83vip3D0cGQHwZTJ944P95MwGlUbKn0o4fmGlFn6xivFW1+Wvel4/3eVoG?=
 =?us-ascii?Q?YX4i7Q3d9flvUDSO1WSD052ZSpvZA1vLGQEr49cv5NFft0hTr+5hDCC4Q+o+?=
 =?us-ascii?Q?i63j1Sru4axfiytqgwe3M1zzDc/06uRS7PUgB7I3eqJ0kGOUW5kAyp7yCnI6?=
 =?us-ascii?Q?iG5jYt2NjE7F1nKapf5Oq51cWgMsTE+G2Ef6DnMFL8WaOAM690bNDsfcDlSu?=
 =?us-ascii?Q?1VXaUWDDgtxKcSzMaLQXY+8WPMshz1kQprjXx1F4m9rIlwox9o8o8dISkcmN?=
 =?us-ascii?Q?b8iy1+p/6ZZVHiuk3et3Chu3dInCrwPnj3v2fybsKT4HdqaSS5ACaJP1Hhzz?=
 =?us-ascii?Q?Quv23kfysBhRuAQymY/Dx6/vML7zQMq3UIwI5HlI2DxtqYakT57Cv1f5YLmQ?=
 =?us-ascii?Q?voXj5CaMjThFGqeU4Rkyncy0/+Wa2PfPATtyZ+n0IVU7nBihlD+6F6FOsyLx?=
 =?us-ascii?Q?/206p73Ls73Rjn+ghQcYAOg+9wUMLtCmPnYfv7PJDPmAbUMCbYTXPgk70/UT?=
 =?us-ascii?Q?7ketIhEUCRMl491nXF1RVEshhQKcS4PFahHdjSovDocw54gi7Fii9NfNZORU?=
 =?us-ascii?Q?qM85MOsFQ8MvjO8NKj52qZeicUylBwAaZ6DLXtdxvOC1g3GduM042Nue/YOR?=
 =?us-ascii?Q?vNgsL3Np9VnSN4yVZdn2jtEsEVC6fFHPy5E8LJSq5eKEik+aK2kX4yihzpY+?=
 =?us-ascii?Q?eyx6lKfpoQ0607JCdiaPKfBF22kh/O41WrUPUnHAUDcNo7FMRnnu3wV8wOzq?=
 =?us-ascii?Q?nzBOHoEaHSdYlzZbNdAG5cOYKf2xNd+eHsYH67op5oO9LBG6X+Hi0KmzI5HK?=
 =?us-ascii?Q?GxIER798SYeP9Yio7Ih1osiBXZI8JXOEEZ1Fj52pjZaqNeW8nXaql68ys0Bi?=
 =?us-ascii?Q?xC1xCV7hfbTmKCjS5mTyHJHfBTtCXTcNfY+Qw4vEOZ/DZySYopZ+Wt2ViQOr?=
 =?us-ascii?Q?iW2O2KN7i6petPB+gTAG7xEEiNWCbumrykYyFgMYhE9sFnSt45S+MSZv7xWF?=
 =?us-ascii?Q?H90bkQ+8YYf4xP7sLPudzgEIJ3Ao/QTU54BdsQz1bzKm/X4CQ/td0NZrSfpN?=
 =?us-ascii?Q?qMOd2fq4t8mK/o4yfbU8/BibYtNS8tR9gUvJWdqXcBUiwujdty8L/VGgrPwq?=
 =?us-ascii?Q?yGb3zt1AP7/+3Iv/hA54Wx7kIezkHxfmWbGZTb4QUrZJK5rmN0q/pP0igBIh?=
 =?us-ascii?Q?Z7u+lqJCqg/j9o/1rcjQl313TIELCfvaPyHc3ksr14wTOIZahmmRp8A4XnpY?=
 =?us-ascii?Q?evrMSr2/w123dsEGnyxXW9u+NaavrQfSRHOO7nDvukLDq/MbhXtovfJths4n?=
 =?us-ascii?Q?p+8X3Piy3UZMbFNdLk8ZBWNr+wILb914UOMxZZaeGVff7P3NexBX8fd7uhOB?=
 =?us-ascii?Q?aWI9JiH1tdTsEBGjudMXIHdhnCoYKeunfV2hYX5eK3EEQFv8A21874PCEjla?=
 =?us-ascii?Q?r6gG+O64kBalxiqZdHc61uVpoMmUGfCOuJ7z28SnEboQ/GplwEvE6M8gHoXp?=
 =?us-ascii?Q?33GqB0LhV028aDMLrl1g0wIrNUEE43whzBjX3tDTlccyfGTvPFlDwAFC8Ex6?=
 =?us-ascii?Q?5rmuE6I5ZraSQI/n5os=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa0ce80-111a-4d33-01c4-08d99390431d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7102.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 06:10:06.3160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmM57bJQOW92oKZjo9axL2lgGkUQ6flrHTnU9Zmeert9mThsag/zueTxPH3mzCQH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7103
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Sep 28, 2021 at 04:24:34PM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-09-28 15:34:47 [+0200], Ard Biesheuvel wrote:
> > Are you sure you want to disable EFI runtime services on all x86
> > systems with PREEMPT_RT as well?
> 
> The only problem that I am aware of is that you need to reboot with
> enabled runtime service (via bootargs, #2) in order to alter boot loader
> settings.

Just provide another case:
Anyone who uses mokutil for enrolling MOK will also need reboot with
efi=runtime first.

> I'm not aware of any other shortcomings. There are no guarantees how
> long an EFI service routine may take.
> That patch is in the RT queue since v4.18-rc8-rt1.
> 
> Sebastian

Joey Lee


Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD466A4B5D
	for <lists+linux-efi@lfdr.de>; Mon, 27 Feb 2023 20:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjB0Tnp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Feb 2023 14:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjB0Tnn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 27 Feb 2023 14:43:43 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2117.outbound.protection.outlook.com [40.107.94.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876001F931
        for <linux-efi@vger.kernel.org>; Mon, 27 Feb 2023 11:43:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKy2rCI0HOjmOG6LChyPzyvJpIS9fvH8a6mvaWSMg4r03nFCaePdkcIs4fyEWKLNZ2v8fto1HMcVJaCeH8I68i5IbhRBKzdbv2Ado515bCqFYY64Hg4bdRtQ4d4NjKAXQ9c01bIbt13U+nn6jgsXtZZ0HWetW7Xqj8aaK+fvjcyfIxktEXb6TUtSye0GHFNDMv6pWa4WW3KT4e0UQfIMl/ZAPotA+nFED2J5eRsByQVeAg8gsi3yFTyO3KEa4S6iu1caMMALe29Nc4ZZqWDCK9oY1B2BMQfa/1oXoFuBA1ChgP/tk+Me142hEX+TJkqGqDQ/ys0A8adu77dobiuPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nh6Ffdgxu62KjH8mwigPAeNbgFOVcW2Qlul2PdczqHA=;
 b=SVJDyQBePnapOy4kXpHxCtNNSSI/Ru6Ts0kdWRvmmoidETpIf+JV58ZrG781z3ct7f6tkFje4ftWVG9apI7S6ePItvnrNtGhgXO2MTIwOHmKFNOzoSeTjx1qlxOoIDRhwem1vLukpF2V93OF7oinLb8lj2VbQyWThBcKs1JVpM9EO3p2pTVM1JZnOgvAhUpbShRWVVq5czvYs2/MWADM/VSMfQ2hv/tFUOrDPeCUW/djZejIIrgmzQpc5cTtaOJspBvPnsJaUKwAzitvczOrTzg1C5bMDql927Ehv3cSJ65GO5sGIXK9ei+8AaZp0O27SM9WK12/JAx6oWQopOi5Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nh6Ffdgxu62KjH8mwigPAeNbgFOVcW2Qlul2PdczqHA=;
 b=LVUgA2Tscbsa50s+H2fhfMgjtDO+rRVCX3Via9QVhtL86TvLi1bZKJbe/3OiENnbWsuV1hpvnBF8hAavPFC2MOerK74L8Lni8tp4gdz3/+PAnch0ErMl7aIh9qIP9pzrs3dCeUWhYxZng4454aKUFpEZCq3ZVOAP+Hpit3Azl+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB7432.prod.exchangelabs.com (2603:10b6:a03:3d3::16) by
 DM6PR01MB4218.prod.exchangelabs.com (2603:10b6:5:1d::21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.29; Mon, 27 Feb 2023 19:43:37 +0000
Received: from SJ0PR01MB7432.prod.exchangelabs.com
 ([fe80::4c59:4ff7:289f:70bf]) by SJ0PR01MB7432.prod.exchangelabs.com
 ([fe80::4c59:4ff7:289f:70bf%4]) with mapi id 15.20.6134.026; Mon, 27 Feb 2023
 19:43:37 +0000
Date:   Mon, 27 Feb 2023 11:43:24 -0800
From:   Darren Hart <darren@os.amperecomputing.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [RFT PATCH 0/2] arm64: efi: Call SetVaMap() with a 1:1 mapping
Message-ID: <Y/0H3PEyxhQ+/hkd@fedora>
References: <20230117142718.564299-1-ardb@kernel.org>
 <CAMj1kXHbWwtxb8dL1G8OG4evTg448Xv_DZ_pi8rNF+oVmdtx4g@mail.gmail.com>
 <Y8bbK30nptwHKn88@dev-arch.thelio-3990X>
 <CAMj1kXFmj9p5xX7bzhatHsj=6JVAtcshN76Dp9Sv8moFBnZc0A@mail.gmail.com>
 <Y8gPnlngCV4cyDEY@dev-arch.thelio-3990X>
 <CAMj1kXEKwy9rZ-a6imw_2wLap87zHFF0UEmfxo8Bsn=x-go1Qw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEKwy9rZ-a6imw_2wLap87zHFF0UEmfxo8Bsn=x-go1Qw@mail.gmail.com>
X-ClientProxiedBy: CH2PR14CA0031.namprd14.prod.outlook.com
 (2603:10b6:610:56::11) To SJ0PR01MB7432.prod.exchangelabs.com
 (2603:10b6:a03:3d3::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB7432:EE_|DM6PR01MB4218:EE_
X-MS-Office365-Filtering-Correlation-Id: e48eebb3-35ad-402b-1c9b-08db18faeafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ixVXzx0426MmIG8O/lkFYDd/0k8T3Y2ExAnOPVbvpDphx1/arH24p94HEUBtR86cOA5GDL/HOdufj/r0vyTF6HIuyWDvEtKRZM+0g461aBzvlefl7UbqD11uOHJGEOfuD/Su/JJJJeR+6cNl9V5S3MB48Q+v2EwQJSNePhqyR7q0SmpWxve6aSlmUoOSybRK8xIB58t4LNTO8/4ZIN8bCOPitybJB4iC9W2NfTjVFha37NK1+V1r+6z4Ty8DaVJIbSpoPY1zpmlS1wGmont4sBDCtyYI8aV7moAeanY1oAVlwPa5Chn6uGQ1pXS92seDAm/ZjRkbRhwzqeP9W6e8OffRzASWcOjvcfO8EG8Onje+wgXW1iQshoklpwjp3mX1NJiQe+SaVIwKtLCxpYjimdX9iqZVDHdEcFIVpUmcGdO9/Vfsa+t7mzLvALZOntwpf/5oEKcv/PoGDfCPvSDZNN5FVqjh2ipxnAGIMl0FPCT5RC2PPfye3va71fc4U34mVwv7hBXOEiamAXNhSV4npV7keaugWj6gz6ovEgoXQqbnFUrVuai5lPyBEK5YL+h3XauIgo5znPf9QaEtgxpQ43GN+z5Vlzcs7wbPgFJZGtXfihV8pNVbfYdofRErycLr5sYjLD1sm/0QETTvbGj+zJUnSrtwmmD3ZhL6ApdyXx18kDdMBZaG2ZI0sNDPye+Rz6pwhYCuNH5imoQwiGqisg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB7432.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(6029001)(7916004)(4636009)(376002)(396003)(136003)(346002)(39850400004)(366004)(451199018)(316002)(54906003)(26005)(38100700002)(38350700002)(6666004)(83380400001)(6506007)(186003)(9686003)(6512007)(33716001)(5660300002)(52116002)(2906002)(8936002)(6486002)(478600001)(86362001)(41300700001)(6916009)(4326008)(8676002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7CAiFbTRT+ozW+ZZkdZ90zKh2Ksr5F/zVc4jqyIJidCHpzw/j6gvcwDsfpev?=
 =?us-ascii?Q?y0QSFoKvpZdrgpns6E3BuAz11VMmxLA8oj8cMNIcjTou7pwky2KQYyMIzDgF?=
 =?us-ascii?Q?K9i0EOzU792UUx8LOo2TCwXFd7Hh2ovrJmwMSRG6abcL6zDZoIUCibfBYPIp?=
 =?us-ascii?Q?S2bEDuT+slcCrKvCwTT+dboe3ZiyB4HzEpaeFiYhkwt3xQvIROd09qZJAZYW?=
 =?us-ascii?Q?3v7bve2fmNXVyrz+2K1UEHfxScyMC5NAniQCGSo3TKU0XpDNnTLLYpQCO19C?=
 =?us-ascii?Q?TvDMO11A+VRlknTD+ldvdzSXWYzJaf5KqpWWfUq+YnSlWxk1AmEJ0icRtuY9?=
 =?us-ascii?Q?dM16udAfhFF1h1+X5VLozfEefQP1tO9urVnfAG1TxNtnAaUpvN+Ja10cU3Um?=
 =?us-ascii?Q?0nMmlgQqhtZfYGdyqG+AuWgYwrUXw5h12oTWsI66GD/JoX4o9fXSAZDH8Ji7?=
 =?us-ascii?Q?G163LvQTNztEAAXNuL+cdbdV2O57oxFkvb8fN5mFJaNgSszAHexLd/BPWUB+?=
 =?us-ascii?Q?dYj/irUfnBT8umoazR1fMFStAqZP1ahOnxZtg55o9dG0BWp3X79l2fVn1xjf?=
 =?us-ascii?Q?0HESGCFVJt+3UUZ4KOpLbHK1xGwMqoBbXhmqDWHGGwlFWKTKH0elJw5ceHZ3?=
 =?us-ascii?Q?V9WGqCPBprCre1tDVy0lPKy/WO+0Z51B8RAWIUp7f2j27ngQn43dq2GtLKIJ?=
 =?us-ascii?Q?rO1lEjJwgncBI4xbrQf0CMlF0J5JHbLzxHtpZwpacmjTlRhdRJwYOVANbcOW?=
 =?us-ascii?Q?xL8b4u7qzmdZoKH7ZAw/E0pXPneppxWmu03OebtGJd0VaaFWAIqIfpGD6dHp?=
 =?us-ascii?Q?c5/R1GlpryPuj32Cy2CnEaaH/tvRYSTpUnknDUar7uxxK2/InEulWHhkgPxn?=
 =?us-ascii?Q?WRCByI7VUziXnnb5+E3M9U6GOc12VmaZvJHgPmdhTxNOkE6dsXdOBs2dhfD4?=
 =?us-ascii?Q?EegFy0f3/wxdT4FSua2i8W2PYEC60CevqXV+hIphu9ex7a+k5O02vH0ZCHmT?=
 =?us-ascii?Q?hlykp/MsSR6/c/wA3HvWuOF+50vPmwhBU9BQfsERhUX0++fkXf0bP6I2NXoq?=
 =?us-ascii?Q?afFesLAgxcNSRLNGn42HUMmYLev5oAbP3ey0xSNFbrKLVFDFE/Zsr2sWiRA7?=
 =?us-ascii?Q?Ob/bsSvynh+PxgKKIXsnvY4MXiuJT1XHIUOMI9LzWe6AWu/stgN9ef6SLOQP?=
 =?us-ascii?Q?np4icBmMwKyiUci5rhO+8dgdS8CHzUNPXrDYVDlgWxcsnAOsbVPkxuQSY3ql?=
 =?us-ascii?Q?k5wFImiA0A4r71zLkLfXQBhjRARLWWbPvEqLohydrijFecG5mGl2A3Szbn8q?=
 =?us-ascii?Q?EwysB2M2b+9WjRUnsYC3P7BSydI6vtQh3gmH9C+OqAIeNStY3ExteM5X3U1C?=
 =?us-ascii?Q?c5iXRCV4pErkfgC/6zX4A3nt7iJJQLb6LiTMj2SFa+vQtvlIZjkDrRx+6LEk?=
 =?us-ascii?Q?1vWlq6m8CW6LmATz5CfyLRxtS2t8IH7yteben9QMOuW/Sn6zQ3TXn+3at8da?=
 =?us-ascii?Q?D1CaidPwzHiBlVebJyH+tm2cLvPYILCf70wfRhyQ/LQB5lh9In3q/3/ZpojE?=
 =?us-ascii?Q?gxKGNINUuWFMRXFlaIu83PC5TlI/n/3GFBjCjZYUFpYfUruD1atc7aIgAazo?=
 =?us-ascii?Q?oFpx/t5sm6R6F7BKdcfAJYU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48eebb3-35ad-402b-1c9b-08db18faeafb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB7432.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 19:43:36.9085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7cBjmnkrd3Nj6zIQVN/pYTRKLyX4L7gQen+B2R0aPcGZgFx7emMjLh8a75LtjQIF82XS5TUrz4F1UlrPE3GDOC45eijT5GpIuohJpl3+0ZCnlVB/y8ZDemo9IR+5jys
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4218
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 18, 2023 at 04:33:29PM +0100, Ard Biesheuvel wrote:
> On Wed, 18 Jan 2023 at 16:26, Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Wed, Jan 18, 2023 at 08:56:54AM +0100, Ard Biesheuvel wrote:
> > > On Tue, 17 Jan 2023 at 18:30, Nathan Chancellor <nathan@kernel.org> wrote:
> > > >
> > > > On Tue, Jan 17, 2023 at 04:20:09PM +0100, Ard Biesheuvel wrote:
> > > > > On Tue, 17 Jan 2023 at 15:27, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > >
> > > > > > Linux on arm64 is now in the same boat as x86, where supporting laptops
> > > > > > that were built to run Windows and never tested beyond what is required
> > > > > > for the Windows Logo certification need workarounds for all kinds of
> > > > > > bizarre behaviors.
> > > > > >
> > > > > > On Snapdragon laptops, we cannot call SetVirtualAddressMap() from the
> > > > > > stub, because the firmware will crash while trying to access memory via
> > > > > > the virtual addresses being installed, which is explicitly unsupported
> > > > > > by the EFI spec.
> > > > > >
> > > > > > However, not calling SetVirtualAddressMap() results in other problems:
> > > > > > on Ampere Altra, it causes SetTime() to crash. On Surface and Flex5g
> > > > > > Windows-on-ARM laptops, it causes ResetSystem() to crash.
> > > > > >
> > > > > > So let's try to work around this while not making too much of a mess.
> > > > > >
> > > > > > First of all, install a 1:1 mapping instead of avoiding SetVaMap()
> > > > > > altogether - from the EFI spec pov, this should amount to the same
> > > > > > thing.
> > > > > >
> > > > > > Then, given that we already use a SMBIOS based hack for Altra to force
> > > > > > the use of SetVirtualAddressMap(), let's check for Surface systems in
> > > > > > the same way.
> > > > > >
> > > > > > Please test, and please report the SMBIOS type 1 family field for which
> > > > > > this workaround is needed.
> > > > > >
> > > > > > Also, note that these changes will not make a difference if the
> > > > > > EFI_RT_PROPERTIES_TABLE lists SetVirtualAddressMap() as not implemented.
> > > > > >
> > > > > > Nathan, I would appreciate it if you could give this a spin on your
> > > > > > Altra box (only patch #1 should make a difference), and for good
> > > > > > measure, double check that hwclock still works as it should.
> > > > > >
> > > > > > Cc: Johan Hovold <johan+linaro@kernel.org>
> > > > > > Cc: Maximilian Luz <luzmaximilian@gmail.com>
> > > > > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > > > > Cc: Steev Klimaszewski <steev@kali.org>
> > > > > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > > > > >
> > > > > > Ard Biesheuvel (2):
> > > > > >   arm64: efi: Prefer a flat virtual mapping of the runtime services
> > > > > >   arm64: efi: Force use of SetVirtualAddressMap() on MS Surface
> > > > > >
> > > > >
> > > > > Bah this does not even work on Yoga C630, so this is not going to help us.
> > > > >
> > > > > If we want ResetSystem() on these machines, we'll have to retain other
> > > > > memory ranges and map the in the EFI runtime map. Yuck.
> > > > >
> > > > > Nathan - still interested in whether patch #1 works on Altra,
> > > >
> > > > I applied patch 1 on top of commit 6e50979a9c87 ("Merge tag
> > > > 'mm-hotfixes-stable-2023-01-16-15-23' of
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm") in Linus' tree
> > > > and everything still appears to be okay with hwclock. If there is any
> > > > more specific testing that I should do, please let me know. Feel free to
> > > > add
> > > >
> > > >     Tested-by: Nathan Chancellor <nathan@kernel.org>
> > > >
> > > > to patch 1 in future revisions, and I am happy to test anything else
> > > > that you might need in this series or future ones.
> > > >
> > > > Mainline:
> > > >
> > > > # uname -mr
> > > > 6.2.0-rc4-00031-g6e50979a9c87 aarch64
> > > >
> > > > # hwclock
> > > > 2023-01-17 09:04:58.845411-07:00
> > > >
> > > > Patch:
> > > >
> > > > # uname -mr
> > > > 6.2.0-rc4-00032-g20165e83052e aarch64
> > > >
> > > > # hwclock
> > > > 2023-01-17 10:25:38.843788-07:00
> > > >
> > >
> > > Thanks Nathan,
> > >
> > > Forgot to mention, though: it is SetTime() not GetTime() that is
> > > problematic on this platform. Could you please double check whether
> > > setting the RTC using hwclock works too?

The other runtime service that triggers this is SetVariable, which I have been
testing like this. The tests still pass on systems with the affected firmware
with the SMBIOS string mitigation in place and this flat va mapping applied.

#!/bin/sh

function set_timeout() {
	TO=$1

	re='^[0-9]$'
	if ! [[ "$TO" =~ $re ]]; then
		echo "Timeout must be 0-9"
		exit 1
	fi

	efibootmgr -t $TO > /dev/null
	efivar -n 8be4df61-93ca-11d2-aa0d-00e098032b8c-Timeout | grep -q "00000000  0$TO 00"
	if [ $? -ne 0 ]; then
		echo "ERROR: timeout $TO not reflected in efivar"
		exit 1
	fi
	echo "SUCCESS: timeout $TO reflected in efivar"
	return 0
}

set_timeout 4
set_timeout 5
exit 0

Thanks,

Darren

> >
> > Ah, okay, makes sense! As far as I can tell, that works too.
> >
> > Mainline:
> >
> > # uname -mr
> > 6.2.0-rc4-00031-g6e50979a9c87 aarch64
> >
> > # hwclock --systohc
> >
> > # echo $status
> > 0
> >
> > Patch:
> >
> > # uname -mr
> > 6.2.0-rc4-00032-g20165e83052e aarch64
> >
> > # hwclock --systohc
> >
> > # echo $status
> > 0
> >
> 
> Thanks again!

-- 
Darren Hart
Ampere Computing / OS and Kernel

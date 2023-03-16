Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB03F6BDBAC
	for <lists+linux-efi@lfdr.de>; Thu, 16 Mar 2023 23:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjCPWaI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Mar 2023 18:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCPW3s (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Mar 2023 18:29:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2133.outbound.protection.outlook.com [40.107.223.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86D928D00;
        Thu, 16 Mar 2023 15:29:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJ+jZZIfQsa73AGJGflPwcyw5zuyUFlAdikHYrPiUl2cGRwUeeGPmIgHd4uaFyXRtRuQbM2EbsU7+xRc5EaU1yTVjlxUNXCX4qZB68ODs3c9lNVdbNYCmG2PJHX8QNNP8f9Jfhe2A1s/I8UIZO8exwb0rOVlaJBln468/++q0wF9Dl9PC0HMTT542JfkjGzaVs1Draf3OtA5bgNgjxMXHwtiiQ5qml/cjoVICP+GbovNFP/+sDryO3H1sdHA9i+4My609XNbTiVBYEA1Cifv3jMyxEKPflK+/sAvJ06UFJWEiykRcCtwGC41UkOkY9UegpGdRM/b2lqDx9HDWqtwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1t+QmoZH/4imk6dCe4+I7NQvUX6r9lPP/F7sAOV7YuA=;
 b=Fo823X1f5F7Emr8niS1t4VGG1zjslTOl6nDSql2H4PWRIT4mHOeLH5WDxPzTwKwIFgDWc+3eRP7bEwpNjdwMlha41fOSK2uAWHH4HUj3iStmOMp07bRhyAjhOcOghrPfkkypeF+gLUy+CYxYLgC6tCLKrHTLFoV0MSIdgxJ1DWfRvmhSk6Q/GBETtcErt0S8u4lceu8oTdgAiIXZijGewIOinD8tklt/36B93f/8zkhZksklfMLi6c2rO+YaALVrXImCsZBAZcxlD08yHWJgIP3C2/9rMNCj5CW3xY0VkXOOjzBhR1fa7HQ9goYrpnM73r5yYnozdw/zNXsGjh9tUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1t+QmoZH/4imk6dCe4+I7NQvUX6r9lPP/F7sAOV7YuA=;
 b=W1jnvGiYsI3bJYqXVmu3QwMsN86e1S6Ck5FDWPzA6iJ/reA1OxWF0PmZGhDMzQP/w5hM5v4TzmS6yBp/sDe8eLTvdm6qPJgKOW9L/UVNsjUGFjmpZ87zwz/w8ijZoVRLaK9YsjWjBO4R272xLCeBc91s+yHSH2bi8wxVIQtOH9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB7432.prod.exchangelabs.com (2603:10b6:a03:3d3::16) by
 CH2PR01MB6040.prod.exchangelabs.com (2603:10b6:610:46::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.8; Thu, 16 Mar 2023 22:28:25 +0000
Received: from SJ0PR01MB7432.prod.exchangelabs.com
 ([fe80::4c59:4ff7:289f:70bf]) by SJ0PR01MB7432.prod.exchangelabs.com
 ([fe80::4c59:4ff7:289f:70bf%4]) with mapi id 15.20.6178.024; Thu, 16 Mar 2023
 22:28:24 +0000
Date:   Thu, 16 Mar 2023 15:28:21 -0700
From:   Darren Hart <darren@os.amperecomputing.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kernel 6.2 stuck at boot (efi_call_rts) on arm64
Message-ID: <ZBOYBdJR00dOKPSx@fedora>
References: <CAMj1kXF=8KoCnRmUyLCZmbfPTeOFQZBeudZuTeA0uHOv-1drFg@mail.gmail.com>
 <ZBMQdgPepwa+VyAH@righiandr-XPS-13-7390>
 <CAMj1kXES+FxxbqUPH5TRjHak2MMC2Yksm0_P6wo__LQMH6Emhw@mail.gmail.com>
 <ZBMes6r2FiAyo81F@righiandr-XPS-13-7390>
 <CAMj1kXG0+NO6HayK2YqSJU0pwj8bn9Un_G-4VJr=hc1ELi-TpQ@mail.gmail.com>
 <ZBMgy+Yh9fDxt44C@righiandr-XPS-13-7390>
 <CAMj1kXEWs43NaTegzmGPFD7UGNVw_13hUCuvmwvKNVYPsfh5Vg@mail.gmail.com>
 <CAMj1kXHKkK+6TDLebZw=H-ZZLVnwPGSRpNNKSbJoPwwA2vhG+w@mail.gmail.com>
 <ZBNXaF32nIh3Ca49@righiandr-XPS-13-7390>
 <CAMj1kXFgmPp8TPDWePNN2wU_TQ87dL940SFEaMKAm4oVaB86+g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFgmPp8TPDWePNN2wU_TQ87dL940SFEaMKAm4oVaB86+g@mail.gmail.com>
X-ClientProxiedBy: CH2PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:610:52::24) To SJ0PR01MB7432.prod.exchangelabs.com
 (2603:10b6:a03:3d3::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB7432:EE_|CH2PR01MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 9664dc4f-12e4-4c08-ce9e-08db266dc15f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qrJYp0xLNrA+sO06t85/MezV5W+e9Ch8uiVVml5GZMIY7VQBhOylDOvs2qQnlmB0e9Qv+PFd3fYA1gWzDQxX45gljDaimQsQsdUoBc5j64tr9q9NW2I+vU+J/odmhE3o/gl1OxVKsKOsStShSRoM3JqxqnkOseg3IbDCeL9Ec9qexp9eQoGKtSRfNkEobBNg6SlZ3wJwPC/waTZCPrL3iYfrcGaCfZrvxWQ7DvV03DYo4o8m1D/HEmrpf77T5loP2a53QbzHKVRzbrYtCEdpSWoWOe9TXrffnTEtLJ5VuB+OE/K3gzudawz0DrXx2B2ULDNgxFi2o80CEXFIbZ0hCTYRZT7SqJNiEDnOAV/u8ohqvhc1hPcu/BW3uHLKXqfcoD0L5Jx/wj61QAhaho7pCW717s+H5+LjYVAazJTraXsj4wbmmmqmI4wHCOM6O6DZ0pa6LfrRA21FcaIuswKhIvxfEN/l16jyYUiNCex1Z3Ub8/OCoj0os7QSSTTUFPQmtpDW8UEj04HFJ9Q9EuxJTNcT/TvykAJ4GaI9s2qXfDX12GFnHfKR+tRV2TIgHaENy+iZjQ/NINGifX1DXeAFLNL8vSh9zjHJx5tO4/DVhDro/E44g62KP49QVIaKJAu4FiS5nGZ6I4mYa3Jhki/x83ghgEZx5Emr0AvsdOmYzCZ0Y1s9KgD2LlsuZ1moVEH7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB7432.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(39850400004)(396003)(376002)(136003)(366004)(451199018)(66899018)(86362001)(33716001)(30864003)(2906002)(8676002)(41300700001)(6916009)(4326008)(5660300002)(8936002)(38350700002)(38100700002)(83380400001)(186003)(26005)(9686003)(6506007)(6666004)(6512007)(54906003)(966005)(52116002)(6486002)(478600001)(316002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pHGc0B5retjfFg2As5pXgm5w5GX4vXAesmcH01w47cCHk6R8J8nOYuunhoIY?=
 =?us-ascii?Q?TTYwls+sjfEShu3PAp1CaNQSdGBq5OtA3IsW7EbCzEL5NGID6rqbXuAfb1zA?=
 =?us-ascii?Q?wfgOxt3UAMD7E/FMB0WoSkBYZs6puBFCY3yTzhZy60J+K5tm+3BHgZY1JbmE?=
 =?us-ascii?Q?fRjPvkYXdnlsiiKMEIRAbjeth6ULVRR1kXEqEAaM74Z7TbVyrFFmsXVBlSfC?=
 =?us-ascii?Q?0OeAxylFfhfJygIvP2Rd3wp9rZqnWvlFB7wn5kPIADmgJRYwgu7c97ztDWkX?=
 =?us-ascii?Q?uXVxZgqCw5kMtpLIYm86Eao+PIc1CESiw8WvpRKsq83RAdFNvraxP0RqscXZ?=
 =?us-ascii?Q?g3TcJr18Zkl5Qkil92XPu1sRpAFtS5OwAku8d8MyMjdCh7IDUInixR182TH9?=
 =?us-ascii?Q?vBkV2Y4ZCkMy2pIgobtxcAiiRCtLtgJ/pnngA2WzAWF1sp5EPV2WHRp28ohr?=
 =?us-ascii?Q?jz6n8Rdd9Nb+2ptjkYICieJgPEHg/aoiqLLwshIQlsGgKogfPyB2tXQTMBmJ?=
 =?us-ascii?Q?HoB1k4nk9AIz1EYCi23uuMDJg0oVksU6M693/YAm5q2TBcxa5XHTvY7AbL4y?=
 =?us-ascii?Q?LmtZtjI3/Pc0maAc8Vi631/tQ3pRw0P6+CzXX4uQKb4Fp5+OzIzMNbq7fq9g?=
 =?us-ascii?Q?SZCGMCAvz+fLPHTgYtsDqjtk696juGovrGHP4D0TZZ4ZJVMOzuAHFXUFQvwD?=
 =?us-ascii?Q?qUKMSlgNGjnZsRnSglg6EiM39z9F1fR6eh8dPXjKEZACXQpD/plT4pZ0V+tF?=
 =?us-ascii?Q?Fh8RogK82Ys2fSltyiBeTGIj/L7brkGwDjHp9+P1rYfXujC72HLQFDDjrdKJ?=
 =?us-ascii?Q?5+qNSHlFamAbaPQMu3GYKoC75R5KgMULCRz30TOOks8ndqMkI23GwSSc2il3?=
 =?us-ascii?Q?BraztTW6MtjapOIGFVfhbM/HcIDDZLX/8UH4iVhNWLPZEfLfxajDob9eUIWF?=
 =?us-ascii?Q?p4DuqSpK6crcqrcO1ldWOXJCsjXd3SM3KG5yv66KyFuOEYhIEoymuQSoHrfc?=
 =?us-ascii?Q?7KsayZoG8rvHJYX7Ar1Dht5kJbMUL70GJa2nZztvKkI1/73qaElvTxzG4Nfe?=
 =?us-ascii?Q?SPIPmQKA0jVHFeBlwz83yRyRGQXGeP+IqET+fa1inhEik9r4Q2p3lRS3lNXV?=
 =?us-ascii?Q?/RwEllynjBrAcAbh021v/n71QHvy8oFkRSH49woY/n4mg7W3O3UF3i9n148G?=
 =?us-ascii?Q?+IQCPqp/n4QWdB4P6Zk03lUW96aJO0W0iXjhS+8UBYHHgXLbZlD+n3QsCzEj?=
 =?us-ascii?Q?17wIXasiv+UXqGcQjhNviEifqOmCz+uvTgb6QrMbVWXH6EbfyX5zwYYkI1Rp?=
 =?us-ascii?Q?SLskK9Q/cU+ui00xpZtrpMqoAVphNPGXsR+FmRy8G03h31ifQFMVH+I8o0wg?=
 =?us-ascii?Q?ztRx1qCI6RT5MqFgWinq8YNBPbu/vQ3FANmSI55wOt6D4BJwrU8Erimo8BpL?=
 =?us-ascii?Q?jyfRAJyHiVFOsab+QQU8k4w0DqVYX/YUNwVhZjncP51ld4bdipgTCG38ySqI?=
 =?us-ascii?Q?7y0acl7Fo8HXXnga6x81SX6nlyMzBawHiE+DE2dGMcFU2NxP0tgGcMOnlzpY?=
 =?us-ascii?Q?3SfPVVzJPfmnBHWCMD+0SsJn+kgi8flsYIrfwq9cNgIUUFvDEHJ+nPOJz4NX?=
 =?us-ascii?Q?5aI2wnRcXJId9iWYktTLPR4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9664dc4f-12e4-4c08-ce9e-08db266dc15f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB7432.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 22:28:24.5315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSlm+tNwdlavjiz1GmIaiA9hClzGBty1oqIn83EfmZ8wIaqBRW0ciAZHUXGZNywmQxAwdeybgcVTdM75jVI3SMPQOe3nd8c7Vg1T4bq8koK14RBxqHTvzb94O0drMLwG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB6040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 16, 2023 at 07:55:36PM +0100, Ard Biesheuvel wrote:
> On Thu, 16 Mar 2023 at 18:52, Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > On Thu, Mar 16, 2023 at 03:08:53PM +0100, Ard Biesheuvel wrote:
> > > On Thu, 16 Mar 2023 at 15:06, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Thu, 16 Mar 2023 at 14:59, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > >
> > > > > On Thu, Mar 16, 2023 at 02:53:24PM +0100, Ard Biesheuvel wrote:
> > > > > > On Thu, 16 Mar 2023 at 14:50, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > >
> > > > > > > On Thu, Mar 16, 2023 at 02:45:49PM +0100, Ard Biesheuvel wrote:
> > > > > > > > On Thu, 16 Mar 2023 at 13:50, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Mar 16, 2023 at 01:43:32PM +0100, Ard Biesheuvel wrote:
> > > > > > > > > > On Thu, 16 Mar 2023 at 13:41, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Mar 16, 2023 at 01:38:30PM +0100, Ard Biesheuvel wrote:
> > > > > > > > > > > > On Thu, 16 Mar 2023 at 13:21, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Thu, 16 Mar 2023 at 12:34, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Thu, Mar 16, 2023 at 11:18:21AM +0100, Ard Biesheuvel wrote:
> > > > > > > > > > > > > > > On Thu, 16 Mar 2023 at 11:03, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Thu, Mar 16, 2023 at 10:55:58AM +0100, Ard Biesheuvel wrote:
> > > > > > > > > > > > > > > > > (cc Darren)
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Thu, 16 Mar 2023 at 10:45, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Thu, Mar 16, 2023 at 08:58:20AM +0100, Ard Biesheuvel wrote:
> > > > > > > > > > > > > > > > > > > Hello Andrea,
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Thu, 16 Mar 2023 at 08:54, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Hello,
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > the latest v6.2.6 kernel fails to boot on some arm64 systems, the kernel
> > > > > > > > > > > > > > > > > > > > gets stuck and never completes the boot. On the console I see this:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > [   72.043484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > > > > > > > > > > > > > > > > > [   72.049571] rcu:     22-...0: (30 GPs behind) idle=b10c/1/0x4000000000000000 softirq=164/164 fqs=6443
> > > > > > > > > > > > > > > > > > > > [   72.058520]     (detected by 28, t=15005 jiffies, g=449, q=174 ncpus=32)
> > > > > > > > > > > > > > > > > > > > [   72.064949] Task dump for CPU 22:
> > > > > > > > > > > > > > > > > > > > [   72.068251] task:kworker/u64:5   state:R  running task     stack:0     pid:447   ppid:2      flags:0x0000000a
> > > > > > > > > > > > > > > > > > > > [   72.078156] Workqueue: efi_rts_wq efi_call_rts
> > > > > > > > > > > > > > > > > > > > [   72.082595] Call trace:
> > > > > > > > > > > > > > > > > > > > [   72.085029]  __switch_to+0xbc/0x100
> > > > > > > > > > > > > > > > > > > > [   72.088508]  0xffff80000fe83d4c
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > After that, as a consequence, I start to get a lot of hung task timeout traces.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > I tried to bisect the problem and I found that the offending commit is
> > > > > > > > > > > > > > > > > > > > this one:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > >  e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > I've reverted this commit for now and everything works just fine, but I
> > > > > > > > > > > > > > > > > > > > was wondering if the problem could be caused by a lack of entropy on
> > > > > > > > > > > > > > > > > > > > these arm64 boxes or something else.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Any suggestion? Let me know if you want me to do any specific test.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Thanks for the report.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > This is most likely the EFI SetVariable() call going off into the
> > > > > > > > > > > > > > > > > > > weeds and never returning.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Is this an Ampere Altra system by any chance? Do you see it on
> > > > > > > > > > > > > > > > > > > different types of hardware?
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > This is: Ampere eMAG / Lenovo ThinkSystem HR330a.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Could you check whether SetVariable works on this system? E.g. by
> > > > > > > > > > > > > > > > > > > updating the EFI boot timeout (sudo efibootmgr -t <n>)?
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > ubuntu@kuzzle:~$ sudo efibootmgr -t 10
> > > > > > > > > > > > > > > > > > ^C^C^C^C
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > ^ Stuck there, so it really looks like SetVariable is the problem.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Could you please share the output of
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > dmidecode -s bios
> > > > > > > > > > > > > > > > > dmidecode -s system-family
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > $ sudo dmidecode -s bios-vendor
> > > > > > > > > > > > > > > > LENOVO
> > > > > > > > > > > > > > > > $ sudo dmidecode -s bios-version
> > > > > > > > > > > > > > > > hve104r-1.15
> > > > > > > > > > > > > > > > $ sudo dmidecode -s bios-release-date
> > > > > > > > > > > > > > > > 02/26/2021
> > > > > > > > > > > > > > > > $ sudo dmidecode -s bios-revision
> > > > > > > > > > > > > > > > 1.15
> > > > > > > > > > > > > > > > $ sudo dmidecode -s system-family
> > > > > > > > > > > > > > > > Lenovo ThinkSystem HR330A/HR350A
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Thanks
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Mind checking if this patch fixes your issue as well?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=altra-fix&id=77fa99dd4741456da85049c13ec31a148f5f5ac0
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Unfortunately this doesn't seem to be enough, I'm still getting the same
> > > > > > > > > > > > > > problem also with this patch applied.
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > Thanks for trying.
> > > > > > > > > > > > >
> > > > > > > > > > > > > How about the last 3 patches on this branch?
> > > > > > > > > > > > >
> > > > > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-smbios-altra-fix
> > > > > > > > > > > >
> > > > > > > > > > > > Actually, that may not match your hardware.
> > > > > > > > > > > >
> > > > > > > > > > > > Does your kernel log have a line like
> > > > > > > > > > > >
> > > > > > > > > > > > SMCCC: SOC_ID: ID = jep106:036b:0019 Revision = 0x00000102
> > > > > > > > > > > >
> > > > > > > > > > > > ?
> > > > > > > > > > >
> > > > > > > > > > > $ sudo dmesg | grep "SMCCC: SOC_ID"
> > > > > > > > > > > [    5.320782] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Thanks. Could you share the entire dmidecode output somewhere? Or at
> > > > > > > > > > least the type 4 record(s)?
> > > > > > > > >
> > > > > > > > > Sure, here's the full output of dmidecode:
> > > > > > > > > https://pastebin.ubuntu.com/p/4ZmKmP2xTm/
> > > > > > > > >
> > > > > > > >
> > > > > > > > Thanks. I have updated my SMBIOS patches to take the processor version
> > > > > > > > 'eMAG' into account, which appears to be what these boxes are using.
> > > > > > > >
> > > > > > > > I have updated the efi/urgent branch here with the latest versions.
> > > > > > > > Mind giving them a spin?
> > > > > > > >
> > > > > > > >
> > > > > > > > In the mean time, just for the record - could you please run this as well?
> > > > > > > >
> > > > > > > > hexdump -C /sys/firmware/dmi/entries/4-0/raw
> > > > > > > >
> > > > > > > > (as root)
> > > > > > >
> > > > > > > hm.. I don't have that in /sys/firmware/, this is what I have:
> > > > > > >
> > > > > > > # ls -l /sys/firmware/dmi/
> > > > > > > total 0
> > > > > > > drwxr-xr-x 2 root root 0 Mar 16 13:26 tables
> > > > > > > # ls -l /sys/firmware/dmi/tables/
> > > > > > > total 0
> > > > > > > -r-------- 1 root root 5004 Mar 16 13:26 DMI
> > > > > > > -r-------- 1 root root   24 Mar 16 13:26 smbios_entry_point
> > > > > > >
> > > > > >
> > > > > > You'll need to load the dmi_sysfs module for that. But no big deal
> > > > > > otherwise, I'm pretty sure the word order is the correct on on your
> > > > > > system in any case (it decodes the value correctly in the next line)
> > > > >
> > > > > ok, much better after modprobe dmi_sysfs. :)
> > > > >
> > > >
> > > > Yeah better, thanks.
> > > >
> > > > > $ sudo hexdump -C /sys/firmware/dmi/entries/4-0/raw
> > > > > 00000000  04 30 04 00 01 03 fe 02  02 00 3f 50 00 00 00 00  |.0........?P....|
> > > > > 00000010  03 89 b8 0b e4 0c b8 0b  41 06 05 00 06 00 07 00  |........A.......|
> > > > > 00000020  04 00 00 20 20 20 7c 00  01 01 00 00 00 00 00 00  |...   |.........|
> > > > > 00000030  43 50 55 20 31 00 41 6d  70 65 72 65 28 54 4d 29  |CPU 1.Ampere(TM)|
> > > > > 00000040  00 65 4d 41 47 20 00 30  30 30 30 30 30 30 30 30  |.eMAG .000000000|
> > > >
> > > > Darn, this means we have to match for "eMAG " (with the trailing
> > > > space) so the branch i just pushed needs to be updated for this.
> > > >
> > >
> > > I.e.,
> > >
> > > --- a/drivers/firmware/efi/libstub/arm64.c
> > > +++ b/drivers/firmware/efi/libstub/arm64.c
> > > @@ -36,7 +36,7 @@ static bool system_needs_vamap(void)
> > >         default:
> > >                 version = efi_get_smbios_string(&record->header, 4,
> > >                                                 processor_version);
> > > -               if (!version || strcmp(version, "eMAG"))
> > > +               if (!version || strncmp(version, "eMAG", 4))
> > >                         break;
> > >
> > >                 fallthrough;
> >
> > Yay! Success! I just tested your latest efi/urgent (with the fixup) and
> > system completed the boot without any soft lockups.
> >
> 
> Thanks for confirming. I'll take that as a tested-by

The solution in the current branch looks like the best approach we have to date
to address the broadest of affected systems. We could switch the eMAG test to an
MIDR test I believe (but this won't work for Altra as that would capture all the
Neoverse v1 cores beyond Altra). I can look into the MIDR test if you think it's
worthwhile - but since I don't think we can eliminate the SMBIOS string test, it
doesn't buy us much since we don't need a greedier eMAG test (there aren't more
of them to match).

Given that some OEM Altra platforms change the processor ID, I don't see a
better solution currently than adding their the "product name" to the smbios
string tests unfortunately.

-- 
Darren Hart
Ampere Computing / OS and Kernel

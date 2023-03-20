Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E3F6C1F11
	for <lists+linux-efi@lfdr.de>; Mon, 20 Mar 2023 19:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjCTSIa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Mar 2023 14:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjCTSHu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Mar 2023 14:07:50 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE8872B7;
        Mon, 20 Mar 2023 11:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frHupDguT01u0Czq5452PoRSYkBB/W28wiVt34WKSYSdnrU2o9FMVpMTG8509yewkeg2OYBD8Lt4awzHe3faqCqJMm/P+Wo78zlalhtc0HM8Dao7vnVWhMlNhIVww8hrGHC+LHVMIdUPsqANfAHTdIfZVfAPsgHe5EtlgYqd0x2RDwc1xBT0d7rWrzrT75V4DF6OMILxs3ZvA154SX/K2JNxLzmm0Gi+btqhCKY6rhO+BId27PmSRFDZxsBkqlTc9Aowt9NZNGBfK6c0VviH+hp6RUU4rgrvgwqq6MIkZZvwUVAMVNmle9smFa1+R72Fsv2YReQH6Llji7m4LJLBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IlKBdpBBOeNdY90080aERrmr+mzCl4HpC9wmWpB1cc=;
 b=DQxBZ+0ZE3rEp+W+vxY+wg+kppklr393HzLoNKQJNTBDESLuxdQWmy7VJVyQoy7t7U9FjCg7URwQ1nXjl16P978lgLTHQTrkGV+1cuwdzD0Np+hz9K2vX8qsot/5gpO/wbsDTBBVXV/eaNYladQm4CZ1wCAZZWzzObB+pb/ivXCveuxP2fLCyJmRImzMv569fKVhEpAFGlp5EpBL11+xfW5pJQIxGZsO5qrCjB/1Q/QlNeWXqVNboZiX12iAjkUW64UG1KRe35qTLs58OhQNQj7E3/yylPXI5iEftZMUN3etKP2+PEEmeBSmSri4diUfhMZLCZzkuMEHnV4e+tamLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IlKBdpBBOeNdY90080aERrmr+mzCl4HpC9wmWpB1cc=;
 b=NDiVY1U/mSPR+FFOZ5MY9MZhQeBbx+dR4R/R/P0b1dBIj+hdQ/yYV0InlDpEadwR0KWO/BqzEYtJkPv+RUJpUfA3HTVbNKhDokpgb5w9xD7fTCO3QmdeZ/OzQcpcyxaq+yLNGhIxfOu2Pj6xgXhxUr9SGP/Vz8whoW0XZ3froro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB7432.prod.exchangelabs.com (2603:10b6:a03:3d3::16) by
 DM6PR01MB5145.prod.exchangelabs.com (2603:10b6:5:56::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.10; Mon, 20 Mar 2023 18:00:49 +0000
Received: from SJ0PR01MB7432.prod.exchangelabs.com
 ([fe80::4c59:4ff7:289f:70bf]) by SJ0PR01MB7432.prod.exchangelabs.com
 ([fe80::4c59:4ff7:289f:70bf%4]) with mapi id 15.20.6222.010; Mon, 20 Mar 2023
 18:00:53 +0000
Date:   Mon, 20 Mar 2023 11:00:48 -0700
From:   Darren Hart <darren@os.amperecomputing.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kernel 6.2 stuck at boot (efi_call_rts) on arm64
Message-ID: <ZBifUCbeEwP/m3ko@fedora>
References: <CAMj1kXES+FxxbqUPH5TRjHak2MMC2Yksm0_P6wo__LQMH6Emhw@mail.gmail.com>
 <ZBMes6r2FiAyo81F@righiandr-XPS-13-7390>
 <CAMj1kXG0+NO6HayK2YqSJU0pwj8bn9Un_G-4VJr=hc1ELi-TpQ@mail.gmail.com>
 <ZBMgy+Yh9fDxt44C@righiandr-XPS-13-7390>
 <CAMj1kXEWs43NaTegzmGPFD7UGNVw_13hUCuvmwvKNVYPsfh5Vg@mail.gmail.com>
 <CAMj1kXHKkK+6TDLebZw=H-ZZLVnwPGSRpNNKSbJoPwwA2vhG+w@mail.gmail.com>
 <ZBNXaF32nIh3Ca49@righiandr-XPS-13-7390>
 <CAMj1kXFgmPp8TPDWePNN2wU_TQ87dL940SFEaMKAm4oVaB86+g@mail.gmail.com>
 <ZBOYBdJR00dOKPSx@fedora>
 <CAMj1kXF8G3G41cPt+5=nB2D_uEaB_iXh6=3ZcTFTHrpsVm5D5g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF8G3G41cPt+5=nB2D_uEaB_iXh6=3ZcTFTHrpsVm5D5g@mail.gmail.com>
X-ClientProxiedBy: CH0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:610:e5::20) To SJ0PR01MB7432.prod.exchangelabs.com
 (2603:10b6:a03:3d3::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB7432:EE_|DM6PR01MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: dca8813d-e5bb-466c-9f13-08db296d0bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9/5vMW/Uz9CBeVUEfFwfxQ8/SnUhtfLB0Yqwwiw1YJH3xVoEO02YsSuTwX4PERGAXYDDu4enL95x1aPqOkCpWG1R878pE14OIEhabOewouVrmeN+aLaHaMBT0H8KyY/NIQMkNRnhvMrd/Kd45vXu2SYMfb1NZq/lm5j6479wQslJSV2tE7oBK3kc6KXRGFYTMSWdO4lrs5CoCTXPdJtAltgWtLiyMqVx18JOEVT8IUoRtJHCBgbm/ZLQwZ+st6FO0VVo112btHWwXlnOIdeIwl7SMrMZnExY0oeyvE3vrnOyH7clivZuuDMQIS1W84eQDQG+GxSXM42XBf8cSqWqvyBDiWGJ2DclqgDfnzBKj7hAskJL+6fq09LEHuQYp8e81cAvBzi6h6csqSvQmeLLWzJXzAaMdK4CFnNd3Ap20VDh/pXZF6DfEKmwviS1d7LrijcnAoitjR2GAvyMRdNqSIZ76btzIbWGtbXfZ1L1BXwg6m3fLlkfGX3NMoUsFceXwGxp+ss2av1Qjl5z92+b9ewLFVBJ3Lk8TBVAeOdi76MU/QC25EH6mXIRGhZyiqwEm1KR3Fn/sKAG50yDSxDPKik/4FhZ8Ud+u83G2WiDL8bbJnFv6ARwxfJvgF4Mw9IdQYq3+nV0mGkTD9y7c6xah5AvMTyzFyRYHM8mNKRnug5w8NrpQ8ARue4h41KA7XK8rRW7vEQlsvEVLmF05xAUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB7432.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(39850400004)(366004)(376002)(346002)(136003)(396003)(451199018)(316002)(54906003)(83380400001)(478600001)(33716001)(38100700002)(38350700002)(86362001)(9686003)(6486002)(52116002)(6512007)(186003)(26005)(6506007)(6666004)(8936002)(4326008)(66476007)(66946007)(66556008)(6916009)(41300700001)(2906002)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KpDUm4h/CfjLvYULL7+5Xbcyc6Be/uirqgPyAcpVpAlOxkT1aass1F5T95SZ?=
 =?us-ascii?Q?anL1t65GhmEAb0nPKweeE4VIOh3AttKKiis34wqWLhP7bmC56kjC7IZi0+eq?=
 =?us-ascii?Q?a7RdVxwYZF+oNLLjxgMNT/9UchAjBI01i414sfVh5nEdsKJus0OiBA6sAiDA?=
 =?us-ascii?Q?IzALGTgDnOoClvKrNS/kfO43KzJPLw3PdkQNmb+h6Qglh8BY5dgQZQT/sfvU?=
 =?us-ascii?Q?4/yu7qp1g23FRfXl0k0B7DUAAfR8nQNhL+OlG+nTmAYicjdauQeXJUYuefmI?=
 =?us-ascii?Q?ng3Z+6tDaxDmW9uzgIfhA2pjGa1ThzeoBdwBHR6iCaAqpFrzc9LBWYs1eAxD?=
 =?us-ascii?Q?CGFCejy0c9ZWFQDcheF4aIX4GJrWAGtPyujB81lqMzug2/l/G1fHgbLV0eRY?=
 =?us-ascii?Q?ofDTxkK0S1waYpJdXwR8moO8/k+HJMebAyGS/wxEwreMZLhOe+eDKNoLEN0/?=
 =?us-ascii?Q?CyizfMj92OyL0D0vMsBefftLbQX5dBHYp33nK66+tJ56Gl0JmYJybYPMxJF5?=
 =?us-ascii?Q?JTuLLY+ZBqjOUBe5LHyf8GsipDtAs5ydIBL6bLdv31Nk8Vk2L5eRAsmIVojp?=
 =?us-ascii?Q?LHZLdvpxl3QOizw0PpdcUdKS1l+i4u/AmKXm1r1WfquJ51ingfpYqxtNlXMs?=
 =?us-ascii?Q?GxtsKNry0jc5hgIrQn4w1dcZNckyP0bMfSWhlZX4GIv8+TAGSu/QJv0lQUMT?=
 =?us-ascii?Q?CuHeICTxdzjUFbbxmIli61CVOnMtXbYRMAHzWrZAY8leyn/7yphzm1wtIiHg?=
 =?us-ascii?Q?bSWcftzD9JK4bzr54tAerRJ/8DndjEAKmWuPB9VhB8FaFl+sxGQaFIwj55iM?=
 =?us-ascii?Q?Kw8Q2S7BH89Rl9vP/bkqYxXHsHh5DnHQBUW3ufx0c5Usw+VFzx89ZXiEHa/F?=
 =?us-ascii?Q?RKquaWjNoXFBv/fLj0cgpkK4w/kpcBj0V7OWqMmnJq2woxym5Zl8d+334i9F?=
 =?us-ascii?Q?D3wSQHEkASuxG/QuLJ9a3pSqhpwYYGakBAfYTgSs7kRfuWEvYkZH2a0buQvR?=
 =?us-ascii?Q?oUzzPwssgV67/rYhr6YWz1vttBH+Nrkd0ELqKdW2OT4tqsL9+xjaBAy6QqXa?=
 =?us-ascii?Q?RCl7lghl5CM2LGsYo2zCHGuX6nzy6v7b7o3Bfv5EYOUkI0w2z7Xf7nnF+iLp?=
 =?us-ascii?Q?EB1Djtl0Yv93AF2r3hr8OSqE38Fi+KRtFXgwH5y+c5OLaDVZgN+wYUUKKX8V?=
 =?us-ascii?Q?7mdTHvlkWUHVH+kU2LAsVUEDZX+vrmOvizVaqu6+eF2F8E6RccGGAzw5aFrx?=
 =?us-ascii?Q?RCYN65AQNP8Uggd0py6yxs+nL9ftU+J37AjiuLJHfmVymbnZYtzl5hxZ5lyw?=
 =?us-ascii?Q?tR41OfvOzlkf1Mi/prnMniXWVv2vs0ktrW8HKebj+lzsmV13NRpHAIAaxHaM?=
 =?us-ascii?Q?04I4kll/yb0oVnGs9TVJ2zgU786t9OBe5wK+T38G/wE9j1+MTDOMhnHYvvzS?=
 =?us-ascii?Q?/iKtlGJoTyrqyrBLyVkQk/ifCegAp62j3dkOFYRvnjKqf9ewZQM2Ly8C5mfT?=
 =?us-ascii?Q?gUtb2j6qnTucnjA0peI0tW5SdmNMXaKlwuZNhV/UuahArawgHWWURygaCGAd?=
 =?us-ascii?Q?55g2z4KuJEcMbBo/21kGv6YJTGGMBsL8cuSz79RFsPIt6FCoK8V/jPJYMylO?=
 =?us-ascii?Q?DkgDIr4oUUxwvi74fKv3gfo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca8813d-e5bb-466c-9f13-08db296d0bc2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB7432.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:00:53.0891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQANShVisSxiLKzQbyzsbxS9trR6AerLFyY2kMrwtbYxdyJq1n8RqKZ7rXhfpurNQRaT2H6yS4+c697+91FmaDMjN2ddferLxoRNkAhY2kTqIh8as9e1nAnGFBvoMtvI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5145
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Mar 18, 2023 at 11:35:44AM +0100, Ard Biesheuvel wrote:
> On Thu, 16 Mar 2023 at 23:28, Darren Hart <darren@os.amperecomputing.com> wrote:
> >
> > On Thu, Mar 16, 2023 at 07:55:36PM +0100, Ard Biesheuvel wrote:
> > > On Thu, 16 Mar 2023 at 18:52, Andrea Righi <andrea.righi@canonical.com> wrote:
> ...
> > > >
> > > > Yay! Success! I just tested your latest efi/urgent (with the fixup) and
> > > > system completed the boot without any soft lockups.
> > > >
> > >
> > > Thanks for confirming. I'll take that as a tested-by
> >
> > The solution in the current branch looks like the best approach we have to date
> > to address the broadest of affected systems. We could switch the eMAG test to an
> > MIDR test I believe (but this won't work for Altra as that would capture all the
> > Neoverse v1 cores beyond Altra). I can look into the MIDR test if you think it's
> > worthwhile - but since I don't think we can eliminate the SMBIOS string test, it
> > doesn't buy us much since we don't need a greedier eMAG test (there aren't more
> > of them to match).
> >
> > Given that some OEM Altra platforms change the processor ID, I don't see a
> > better solution currently than adding their the "product name" to the smbios
> > string tests unfortunately.
> >
> 
> Indeed. I spotted a Gigabyte system [0] with a different processor ID,
> but with a version we can test for.
> 
> So for now, I'll go with
> 
>         socid = (u32 *)record->processor_id;
>         switch (*socid & 0xffff000f) {
>                 static char const altra[] = "Ampere(TM) Altra(TM) Processor";
>                 static char const emag[] = "eMAG";
>         default:
>                 version = efi_get_smbios_string(&record->header, 4,
>                                                 processor_version);
>                 if (!version || (strncmp(version, altra, sizeof(altra) - 1) &&
>                                  strncmp(version, emag, sizeof(emag) - 1)))
>                         break;
> 
>                 fallthrough;
> 
>         case 0x0a160001:        // Altra
>         case 0x0a160002:        // Altra Max
>                 efi_warn("Working around broken SetVirtualAddressMap()\n");
> ...
> 
> which should cover all the affected systems we encountered so far.
> 
> I'll push this to linux-next to let it soak for a little bit, and then
> send it to Linus somewhere during the week

Thank you Ard, I think this is our best option.

-- 
Darren Hart
Ampere Computing / OS and Kernel

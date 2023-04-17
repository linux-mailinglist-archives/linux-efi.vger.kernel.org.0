Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133466E548A
	for <lists+linux-efi@lfdr.de>; Tue, 18 Apr 2023 00:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjDQWF3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Apr 2023 18:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjDQWF2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Apr 2023 18:05:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2132.outbound.protection.outlook.com [40.107.92.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2846A1B4;
        Mon, 17 Apr 2023 15:05:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0Va9hHYRBx2KocUMiiewpSYLVmOacZ06Nj733OnvgAP/pvMb9ONTETwDd2ExaGD+GrJvPPvep1+iauwlo7he91SbYUVojMBD95MtbPIl4Nh3wCFfxTjHUoiIvTOe8gjf6dNSx4Da4YITKnx9EpJNY7sqXXGYriTp7JvsiyjkJhastx0UVBuDZZ4wi4Sg5XesbKTqrmDoaTsMnIRXcHn3N9T48aq3KDtOEroKx4zWpxNhvGeInzhuCPC9+Zj4/1VoY9ma9+w0fa8uOAnP33+fXL/u2Wj+ekiy6rTm/RuvLzPepjT0tRAqK6ioBO3+yo8ad+LRBf7uf4DLOTf3qGelw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xn2yzfb0M9gWtmvoQj9dkkfPLywYMKcFtZQV6v4OvGA=;
 b=MEgfQRApDlH3fFUESbsI/Pv0r8AU8doEGbqPlJxlgKXNFgYJSRW0VGhMYzl8IA5wlpXQE44t3ss0ot8wdXGESn3nve1Mf4snxfAnjqoA2ZV2KpkIp2iqBkjArKFT3BrpQySssj2rcxCqouSX5w03QLtXc2tayvVMGMJo1mPVpRaSJETMO0ZY82lxueMBHA8R0J6v5DCaigVrFP/FPFrKfRgz2Qkj67CNw4pvz46IZKWbBifEk92Vkd9OfFG8NPTMEU1tU3n2p+zpIjdaCl+TwskiOeFKayTKh1STQhq8dkRVUJaFISc60h2LKOSB4woDmA63p8fQaRRp16XTv1KfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xn2yzfb0M9gWtmvoQj9dkkfPLywYMKcFtZQV6v4OvGA=;
 b=YS9P/H/smJDPB+eGSpoUq0e0UjCuQYDS9OKSP6E6WbA4WyMZwJ1kFKHA1U+UTVACq0fuUNiN3HRW6kMvWDvDq5KNfPbHFcQq+z3N1GVVWvbzTM5aOtsJ7THzFgXPoBTecLS0wYgyYWgcP6v4b41FHsOuNQVF1OEUHICJKwvtOT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB7432.prod.exchangelabs.com (2603:10b6:a03:3d3::16) by
 PH0PR01MB7948.prod.exchangelabs.com (2603:10b6:510:286::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.9; Mon, 17 Apr 2023 22:05:21 +0000
Received: from SJ0PR01MB7432.prod.exchangelabs.com
 ([fe80::c091:3fdb:5662:5198]) by SJ0PR01MB7432.prod.exchangelabs.com
 ([fe80::c091:3fdb:5662:5198%3]) with mapi id 15.20.6319.006; Mon, 17 Apr 2023
 22:05:21 +0000
Date:   Mon, 17 Apr 2023 15:05:18 -0700
From:   Darren Hart <darren@os.amperecomputing.com>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kernel 6.2 stuck at boot (efi_call_rts) on arm64
Message-ID: <ZD3CniUzNXVJRthE@fedora>
References: <ZBMes6r2FiAyo81F@righiandr-XPS-13-7390>
 <CAMj1kXG0+NO6HayK2YqSJU0pwj8bn9Un_G-4VJr=hc1ELi-TpQ@mail.gmail.com>
 <ZBMgy+Yh9fDxt44C@righiandr-XPS-13-7390>
 <CAMj1kXEWs43NaTegzmGPFD7UGNVw_13hUCuvmwvKNVYPsfh5Vg@mail.gmail.com>
 <CAMj1kXHKkK+6TDLebZw=H-ZZLVnwPGSRpNNKSbJoPwwA2vhG+w@mail.gmail.com>
 <ZBNXaF32nIh3Ca49@righiandr-XPS-13-7390>
 <CAMj1kXFgmPp8TPDWePNN2wU_TQ87dL940SFEaMKAm4oVaB86+g@mail.gmail.com>
 <ZBOYBdJR00dOKPSx@fedora>
 <CAMj1kXF8G3G41cPt+5=nB2D_uEaB_iXh6=3ZcTFTHrpsVm5D5g@mail.gmail.com>
 <ZDhlBjbRGufpDm6u@righiandr-XPS-13-7390>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDhlBjbRGufpDm6u@righiandr-XPS-13-7390>
X-ClientProxiedBy: CH0PR03CA0408.namprd03.prod.outlook.com
 (2603:10b6:610:11b::9) To SJ0PR01MB7432.prod.exchangelabs.com
 (2603:10b6:a03:3d3::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB7432:EE_|PH0PR01MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: a5539afb-d613-49d6-c67a-08db3f8fd640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PPeZSTOg6B5gYav1KMafpgJr8OIIlINhyUxs4KxwFszbtBQJ+Nnkju7aqOLZlwiw/BIS8Q/dH03WIj6LTIwc9LCEh13DVWB7t4vn58nkzwbIt4x8vz6QfeEzNlsv6s/b71yZ0P/5+RBKV7bIZHveGpk1otgNVTvg07qTVLOkZUyqUN/lFMNKL6Ncfij+6EOPrAlKfpuM3ddarE4lXX8h5arEG2hgLZrvQCOT/nbDF/y7iIot2sDVxmZUcPeqo5jwX75mKk2FtgxncBfN37MCsfViJlOtKU6jjftpAp/xHL6YaWLSY26QsshgiwxPGSovSrNAdmVdLVjfzkKk071+zSrzVzNFfizrO2hoq6L3TWm95+eqL1IC4NtoJVTSQUkDanhMmr17JP0Rh8w4CoXpfz0PuQusZJAUBvP4O6Zuc9gmyvg1/anVNYTMxc8tkbeMk2AT70/rSPnUp89wj9lf/rsX2PlboavELTqCtcEVnThgpro8JRj/LdZ3tuYTN5Q1XmXK2/D8y8ZfgbvCWdhtMtSM0TZR0NAnSZt4A3PSc+GIhmC/B7fHqxCAOWRhst8yNFeIDInLDNRGNetOrmQXnLZA4KlmYK3NRnZ3tvsqZsfjd6IGoOvqN7FakU2fG6Zi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB7432.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(376002)(396003)(346002)(366004)(39850400004)(451199021)(66476007)(66556008)(41300700001)(66946007)(38100700002)(4326008)(83380400001)(52116002)(54906003)(478600001)(8936002)(6666004)(6486002)(8676002)(316002)(5660300002)(2906002)(38350700002)(6916009)(6506007)(186003)(9686003)(26005)(6512007)(86362001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s/zxz16Ij9hBK63glTBwpqXfR8Ju6XmvDWCn0VRtnQvj4JoB2g6WO3AUvwhL?=
 =?us-ascii?Q?Hj+cGspuRroe10qhUHyNjxogy1k+pHTMLXANvQnwIhzWvAPUqORMG8RRFve1?=
 =?us-ascii?Q?AuP5XuL3JGai8nxicNrN3UhL8y5YkpRK1zOKiZE+/kXfmgwkEvtXKhbCOyIs?=
 =?us-ascii?Q?WRMoP7szRhKNmj+xvi7knVEfHVMjnNF904W+ohvOmAueiaGbNS/yitvQG4GY?=
 =?us-ascii?Q?oHMYyj7BvO7ukxTAOOgq9F8BYma2Hcl98tMZUD0cBvFSD80KrJw83tS/LlqQ?=
 =?us-ascii?Q?DYDSpVZPox+5L4LlHFCU7CkHE0Aa0bsEWBKYLHKT99JNSFHBrYamxjkgssA2?=
 =?us-ascii?Q?dIbbKVK6ShWjjxWyjQy9t4VYaGtl3upoXc8HOGlen+voctAljdlXZ1U+mV/v?=
 =?us-ascii?Q?3TwTr6LHR7TCFyKjQ+eamzsHfEYvmc4cBBCUbDqnRlIbcWnu8BJpSt3ZU9dj?=
 =?us-ascii?Q?HtWYeV2b5lPKcSI+4SY7iU2GR24ff+D3wFH6FxC96no8QMpWl1oVDLETjjvD?=
 =?us-ascii?Q?whho0LnXf0b2HSdiDdf4Yol2JfU2I25rJdLsDnQ6kUKFO7AFc4VxHJ+0Yrid?=
 =?us-ascii?Q?uBFUdWr07jpG/3BPTesd3CcjafFY/zxM8aM0Vx4RduacQ7rfF1OSxLOxrf3n?=
 =?us-ascii?Q?O4rmLNk2U/TfQ1IdJgcXJFzFfmeMHa/ZC86HUFaK5wfReysQFiAmljIGQp2X?=
 =?us-ascii?Q?QK9P+lyDoVAS4O++Y48Nfznbenddys1RPM6XS2H4+bBTN4sQRNHIvimhzDMx?=
 =?us-ascii?Q?a/KD1DqhyKBM/C+g3x9LJMse345gv8S/pS6ZQUuXe5t7Q/lFsg+u8t8X/4yS?=
 =?us-ascii?Q?HH3Zq2KOfFb8lDx2rNZdKWIUnhDjpVqDrV4U0Dhm+Xy0VZx1z9267Q3dNE6r?=
 =?us-ascii?Q?WrHnWKcsdOBfok1nnSUOVlCXf6YgheokiTKg4kqZJV8H51REOnr8ExdbI0+Z?=
 =?us-ascii?Q?PER6xoHAm1Y9GsWC0uy+5JPYWx1rTF2LUinvh4EygdC8RU/juxJyeJQOH+qM?=
 =?us-ascii?Q?dECezTEcTeGn19MGwoD1Ta7I1CyqhK/xjtti+XbGd/ty8IWh6TvL8pWHhHLT?=
 =?us-ascii?Q?AgGyy2eAW3CntfovPlX4b+0RRv6YCoWg5x5VVbe4HFYFi8s1A3E0j/tj6VKL?=
 =?us-ascii?Q?vPKu62rFDEZqLiBfoYoOswiBwq71HiM3+5yg+9tdC7uT2AX29EudV8zVc8qC?=
 =?us-ascii?Q?PNnWcS5XrHlwJkRgZcLpEDHzO4TKAlsKxUhAeiO2j87uxpM2Fc26f0QdQq7I?=
 =?us-ascii?Q?OFIg1lDcFxSwV3IKlGC5KMBsMatVskr3fxnf8Yhmsk/f/ZNmxDNYYxPxKpV1?=
 =?us-ascii?Q?6xN2OKa9QCNBG4i0s2gfxYrnC13az94o/fh2j+BFHYamJ4WZNCXC9gifYjGi?=
 =?us-ascii?Q?vPqF+VSAZm2DXAmjcP3YFE0wIVD99mt4ay/QjpnhlqJnom4w0Rjuqm4h9lWA?=
 =?us-ascii?Q?HCKJa0G5XktCrxkl91NiPNDCQjAwd3olHZM57flHtRrkiWFezRBC7zYxU8nq?=
 =?us-ascii?Q?znRMeh4SYcA0kFNrCZCPh1d3HF/xyi4ASHuvL1/cqLCT9/OMEN5I/qwryh6f?=
 =?us-ascii?Q?y8MOx9TOKM8cE0E+UeIrxREU4N3272G1Occ8hSIelgBUhfavHAxJPUbRfvZk?=
 =?us-ascii?Q?1/aB5B9NhtBy4jagJk5m2qM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5539afb-d613-49d6-c67a-08db3f8fd640
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB7432.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 22:05:21.4842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4B4OJPsBND1LgFsaVv+R0Q6ZQWMyZeUhS7d46cinWkqJM7I2vNQ5EznI8nh42fSLlkrNDfjz4kptfmuJcVbekxK1OL6JaWE83LcrskyixkPPv1mC7rQyswfD4Qjk1Trv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7948
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Apr 13, 2023 at 10:24:38PM +0200, Andrea Righi wrote:
> 
> Not sure if it's a similar issue, but I have found another Ampere box
> that is booting fine with your fixes, but the eifvars.sh kselftest is
> failing with some I/O errors, specifically:

Thanks for reporting. Can you confirm this worked reliably for you prior
to v6.1?

--
Darren

> 
> $ sudo ./efivarfs.sh
> --------------------
> running test_create
> --------------------
> ./efivarfs.sh: line 58: printf: write error: Input/output error
> /sys/firmware/efi/efivars/test_create-210be57c-9849-4fc7-a635-e6382d1aec27 has invalid size
>   [FAIL]
> --------------------
> running test_create_empty
> --------------------
>   [PASS]
> --------------------
> running test_create_read
> --------------------
>   [PASS]
> --------------------
> running test_delete
> --------------------
> ./efivarfs.sh: line 103: printf: write error: Input/output error
>   [PASS]
> --------------------
> running test_zero_size_delete
> --------------------
> ./efivarfs.sh: line 126: printf: write error: Input/output error
> ./efivarfs.sh: line 134: printf: write error: Input/output error
> /sys/firmware/efi/efivars/test_zero_size_delete-210be57c-9849-4fc7-a635-e6382d1aec27 should have been deleted
>   [FAIL]
> --------------------
> running test_open_unlink
> --------------------
> open(O_WRONLY): Operation not permitted
>   [FAIL]
> --------------------
> running test_valid_filenames
> --------------------
> ./efivarfs.sh: line 158: printf: write error: Input/output error
> ./efivarfs.sh: line 158: printf: write error: Input/output error
> ./efivarfs.sh: line 158: printf: write error: Input/output error
> ./efivarfs.sh: line 158: printf: write error: Input/output error
>   [PASS]
> --------------------
> running test_invalid_filenames
> --------------------
>   [PASS]
> 
> If it helps:
> 
> $ sudo hexdump -C /sys/firmware/dmi/entries/4-0/raw
> 00000000  04 30 04 00 01 03 fe 02  c1 d0 3f 41 00 00 00 00  |.0........?A....|
> 00000010  03 8a 72 06 b8 0b f0 0a  41 06 05 00 06 00 07 00  |..r.....A.......|
> 00000020  04 05 06 50 50 50 04 00  01 01 01 00 01 00 01 00  |...PPP..........|
> 00000030  43 50 55 20 31 00 41 6d  70 65 72 65 28 52 29 00  |CPU 1.Ampere(R).|
> 00000040  41 6d 70 65 72 65 28 52  29 20 41 6c 74 72 61 28  |Ampere(R) Altra(|
> 00000050  52 29 20 50 72 6f 63 65  73 73 6f 72 00 30 30 30  |R) Processor.000|
> 00000060  30 30 30 30 30 30 30 30  30 30 30 30 30 30 32 35  |0000000000000025|
> 00000070  35 30 32 30 39 30 33 33  38 36 35 42 34 00 30 30  |50209033865B4.00|
> 00000080  30 30 30 30 30 31 00 51  38 30 2d 33 30 00 00     |000001.Q80-30..|
> 0000008f
> 
> I guess EFI is not very reliable here...
> 
> -Andrea

-- 
Darren Hart
Ampere Computing / OS and Kernel

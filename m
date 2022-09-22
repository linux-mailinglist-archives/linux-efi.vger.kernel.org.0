Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A0D5E6DBB
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 23:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiIVVKf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 17:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiIVVKd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 17:10:33 -0400
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65307D1F8;
        Thu, 22 Sep 2022 14:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=851; q=dns/txt; s=iport;
  t=1663881031; x=1665090631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vganC7W5irzHuK0hffp/PseJz28ORkjAfA5hJ9l7l4g=;
  b=mbcbC7dkiNYHn/yMNrOdsMbgbt0pZYn/KH0NUdVHsgVcEzZI310meZ9R
   iDeti2j9Rs3w7H2h1xVDFMkaO1xAC8dK9tl27zTHv8BIbj+05+35Jbpl/
   ++dSQSnGVnwYLtK/spFsWPmb8rdY/gHIS/lzQCovGM/Qc10AhumKDGhBD
   U=;
IronPort-Data: =?us-ascii?q?A9a23=3AUy0loqPIn6DGLK7vrR00lsFynXyQoLVcMsEvi?=
 =?us-ascii?q?/4bfWQNrUon12BTyTMWW2DUaK3YZjPxLo1+b4i28B5S7cDdydJjG3M5pCpnJ?=
 =?us-ascii?q?55oRWUpJjg4wn8dtEp+F+WbJK5cx5hYO4CowPwcFCeG/E/wa+a59BGQ6InRL?=
 =?us-ascii?q?lbCIL+cUsxObVcMpBcJ0XqPqsZh6mJaqYHR7zCl4bsel/bi1GqNgFaYBI67B?=
 =?us-ascii?q?5Wr83uDtNyq0N8RU8dXifpj5DcynFFNZH4TyD3YEpf2fmVUNrbSq+fr1rq1+?=
 =?us-ascii?q?CbS+A0gT4/jmbfgeUpMSbnXVeSMoiMJAO753V4T/Wprj/tT2Pk0MS+7jx2Fl?=
 =?us-ascii?q?tZwxdFSvLS7SBwiOevHn+F1vxxwQ3kjbP0aoueWSZS4mYnJp6HcSFPowvNzH?=
 =?us-ascii?q?AQ7M4ww5Ol6GydN+OYeJTRLaQqM78qywbSmWqxvjNkiKMXDIowSoDdjwCvfA?=
 =?us-ascii?q?PJgRorMK43G6MFZ1zosnM1DNejRatBfajd1ahnEJRpVNT8/DJM4gffthXTld?=
 =?us-ascii?q?TBcgEyaqLBx4GXJygF1lr/3P7L9ft2MWNUQl1yd42HL5WL0BjkeNceD0nyE9?=
 =?us-ascii?q?Hy2j+PClC+9X5gdfJW47vdCkkyPwXZVAxoTPXO/oP+kmlamUJdTJlI8/is1s?=
 =?us-ascii?q?bN0816vR9PmGRqirxasuh8aRsoVFuwi8ymTxafOpQWUHG4JSnhGctNOnN9mG?=
 =?us-ascii?q?xQp20WPktevAiZg2JWcSmqY3rOVqy6ifCYSMGkObDMFSg1D5MPsyKk/hxTOQ?=
 =?us-ascii?q?9JLH6+wltDxFC/xyDDMtyE4wrsJhMgA1r6w+hbMinSxvfDhVAk/5i3UU3ij4?=
 =?us-ascii?q?wc/Y5SqD6Sj6ULa9upHNIaUCF2Mpn8Vs8OF4/oJEInLmTHlaPoMGLWB5PufN?=
 =?us-ascii?q?jDYx1l1EPEJ7Dmk/Tiqe4xd+ip5Im9yP80DPzTuZSfuVal5jHNIFGGhYakya?=
 =?us-ascii?q?IWrBoF2i6PhDt/iEPvTa7JzjlFKXFfv1ElTiYS4hggBSHQRrJw=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A0r06i6lakzFvmjzxnh/v/ne4t2zpDfIp3D?=
 =?us-ascii?q?Abv31ZSRFFG/FwWfrAoB0+726QtN9xYgBDpTnuAsO9qB/nmKKdpLNhWYtKPz?=
 =?us-ascii?q?OW21dATrsC0WKK+VSJcBEWtNQ86U4KScZD4bPLYWSTSa3BkW+F+xFK+qjhzJ?=
 =?us-ascii?q?yV?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CHAwBDbIJi/5tdJa1aH2qBT4Ird1Q?=
 =?us-ascii?q?9Q5M0giiRR4sdFIFoCwEBAQ0BATkJBAEBgU6DNAKFPgIlNAkOAQIEAQEBEgE?=
 =?us-ascii?q?BBQEBAQIBBwSBCROFaA2GQwEFOj8QCxguVwYTgn6DFw+rR3iBM4EBg08BGBi?=
 =?us-ascii?q?EGYFfBiSBGI5gJxyBSUSEPz6EKoZVBJVjOwNUgQUSgSFxAQgGBgcKBTIGAgw?=
 =?us-ascii?q?YFAQCExJTHgITDAocDlQZDA8DEgMRAQcCCxIIFSwIAwIDCAMCAyMLAgMYCQc?=
 =?us-ascii?q?KAx0IChwSEBQCBBMfCwgDGh8tCQIEDgNDCAsKAxEEAxMYCxYIEAQGAwkvDSg?=
 =?us-ascii?q?LAxQPAQYDBgIFBQEDIAMUAwUnBwMhBwsmDQ0EHAcdAwMFJgMCAhsHAgIDAgY?=
 =?us-ascii?q?XBgICcQooDQgECAQcHiUTBQIHMQUELwIeBAUGEQkCFgIGBAUCBAQWAgISCAI?=
 =?us-ascii?q?IJxsHFjYZAQVdBgsJIxwsCwYFBhYDJlIGIgGVdgiBeYFBgj2SfIJijRiBL5x?=
 =?us-ascii?q?7g1aBQ4lXlFZLEahGlmaNJ5lXAgQGBQIWgWE8gVkzGggbFYMjEz4ZD5cmhWo?=
 =?us-ascii?q?kMQI5AgYLAQEDCZEaAQE?=
X-IronPort-AV: E=Sophos;i="5.91,230,1647302400"; 
   d="scan'208";a="805984209"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 22 Sep 2022 21:10:29 +0000
Received: from zorba ([10.25.129.98])
        by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id 28MLAQTc012966
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Sep 2022 21:10:28 GMT
Date:   Thu, 22 Sep 2022 14:10:26 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH 0/8] generic command line v4
Message-ID: <20220922211026.GW4320@zorba>
References: <20210416040924.2882771-1-danielwa@cisco.com>
 <b517fac5-2fdc-a8c9-75d0-174c67f5a2de@seco.com>
 <20220922205334.GV4320@zorba>
 <dcff9b0f-82c8-5aa7-0fff-b749a05fcb20@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcff9b0f-82c8-5aa7-0fff-b749a05fcb20@seco.com>
X-Outbound-SMTP-Client: 10.25.129.98, [10.25.129.98]
X-Outbound-Node: rcdn-core-4.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 22, 2022 at 05:03:46PM -0400, Sean Anderson wrote:
> 
> 
> 
> On 9/22/22 4:53 PM, Daniel Walker wrote:
> > On Thu, Sep 22, 2022 at 04:45:01PM -0400, Sean Anderson wrote:
> >> 
> >> 
> >> 
> >> For an arm64 platform (after rebasing):
> >> 
> >> Tested-by: Sean Anderson <sean.anderson@seco.com>
> > 
> > Maybe I'll re-submit it.
> > 
> > Daniel
> > 
> 
> There's still no way to extend the command line on ARM64, since the
> existing method was removed in anticipation that your series would be
> added. 
> 
> As recently as last month, someone's patch to add such support was
> rejected for this reason [1].
> 
> --Sean
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20220812084613.GA3107@willie-the-truck/


I had no idea.. Thanks for pointing that out. I guess I will re-submit in that
case.

Daniel

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB99C66A5D1
	for <lists+linux-efi@lfdr.de>; Fri, 13 Jan 2023 23:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjAMWUc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Jan 2023 17:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjAMWUb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Jan 2023 17:20:31 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CE676AE9;
        Fri, 13 Jan 2023 14:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673648430; x=1705184430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kYRee6SEDeSRw1BGWOZXLgclS1shhcx9XIZ3iu9LATE=;
  b=NcmMEspQMBoNrNPHUT7rwiM4zQLJybxJnHaGmqGoqw4ZO3fgtO0lVAXG
   gCHUcs1djtY6VlNUshY54ujuMzpnAN0UlUpTLVISzn0Ajk3GfskFFMOUp
   8gq6KHf/oIlzG2Ruv7JDGEhtjxnAeKOaFJQ7lQZnuToBD+TGKjIXBSQU4
   VU2Xa6Y4NtUmKUr8cG1I/ttEmVM7sYmWRYkSbgO872eH95aI7+59G2uYj
   8M/l0NEbtqOrfB4uYmCZ7jgJdFBjLFkrljBwlVKuahYGSyAZxXSNYId00
   Lsptv7ft3l6qCugXmz18O1GMXbH9gspiDvTMZK1dz+6kmCNpyarvftBkI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="304495071"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="304495071"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 14:20:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="747070008"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="747070008"
Received: from wkoter-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.50])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 14:20:27 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E6D41109AF4; Sat, 14 Jan 2023 01:20:24 +0300 (+03)
Date:   Sat, 14 Jan 2023 01:20:24 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dionna Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        x86@kernel.org, jiewen.yao@intel.com, devel@edk2.groups.io,
        Ard Biescheuvel <ardb@kernel.org>,
        "Min M. Xu" <min.m.xu@intel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2] x86/efi: Safely enable unaccepted memory in UEFI
Message-ID: <20230113222024.rp2erl54vx3grdbd@box.shutemov.name>
References: <20230113212926.2904735-1-dionnaglaze@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113212926.2904735-1-dionnaglaze@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 13, 2023 at 09:29:26PM +0000, Dionna Glaze wrote:
> This patch depends on Kirill A. Shutemov's series
> 
> [PATCHv8 00/14] mm, x86/cc: Implement support for unaccepted memory
> 
> The UEFI v2.9 specification includes a new memory type to be used in
> environments where the OS must accept memory that is provided from its
> host. Before the introduction of this memory type, all memory was
> accepted eagerly in the firmware. In order for the firmware to safely
> stop accepting memory on the OS's behalf, the OS must affirmatively
> indicate support to the firmware.

I think it is a bad idea.

This approach breaks use case with a bootloader between BIOS and OS.
As the bootloader does ExitBootServices() it has to make the call on
behalf of OS when it has no idea if the OS supports unaccepted.

Note that kexec is such use-case: original kernel has to make a decision
on whether it is okay to leave some memory unaccepted for the new kernel.

And we add this protocol to address very temporary problem: once
unaccepted memory support get upstream it is just a dead weight.

Let's not do this.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

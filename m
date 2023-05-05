Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D134B6F8692
	for <lists+linux-efi@lfdr.de>; Fri,  5 May 2023 18:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjEEQWb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 May 2023 12:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjEEQW3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 May 2023 12:22:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BE2160B8;
        Fri,  5 May 2023 09:22:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06ABC63F1E;
        Fri,  5 May 2023 16:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6C2C433EF;
        Fri,  5 May 2023 16:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683303747;
        bh=2K2sG1iqgAgCjF6w7LO1DpRP8tMIRvNOwwZ3Bg4XUBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GZEwRFBu3OZwQgVrSyO4Ynl8ZobRrx7IJaO2Ag95MO9QXmRVqWD4FI+or+I91IfV8
         RJGPzYzK6nSrGitFu88EAj3lGYv+fFDD3wfltYOjqhppvwFmI06OI4DqgzgN+OxuzC
         ephmYdlUjJc48hQ7NEGyiDNgTaYJLvpBMW57huB3RYYhwaAUW8fwSn23THU9dAYkDw
         PqaObywOHOQfeGhuXy4GCnJKCxnBgMTs/DAQtM7YRj7ouzp9qR3VMboqANSLpH9fnM
         m++qETHrN5sEWH6zmRDzXt+mWb/EDniTdmX54yj3+wuskkZJf8BeNqK8gPLx+4MbIc
         86Q9Zw5nvY0hg==
Date:   Fri, 5 May 2023 18:22:21 +0200
From:   Simon Horman <horms@kernel.org>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 04/14] x86: Secure Launch Resource Table header file
Message-ID: <ZFUtPbgvG0qifhnV@kernel.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-5-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-5-ross.philipson@oracle.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, May 04, 2023 at 02:50:13PM +0000, Ross Philipson wrote:
> Introduce the Secure Launch Resource Table which forms the formal
> interface between the pre and post launch code.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  include/linux/slr_table.h | 270 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 270 insertions(+)
>  create mode 100644 include/linux/slr_table.h
> 
> diff --git a/include/linux/slr_table.h b/include/linux/slr_table.h

...

> +static inline void *slr_end_of_entrys(struct slr_table *table)
> +{
> +	return (((void *)table) + table->size);
> +}
> +
> +static inline struct slr_entry_hdr *
> +slr_next_entry(struct slr_table *table,
> +		struct slr_entry_hdr *curr)

nit: The indentation of the line above doesn't align with the '(' on
     the line before it.

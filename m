Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B8F70063D
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 13:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240732AbjELLE1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 May 2023 07:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbjELLE0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 May 2023 07:04:26 -0400
X-Greylist: delayed 252 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 May 2023 04:04:20 PDT
Received: from cavan.codon.org.uk (irc.codon.org.uk [IPv6:2a00:1098:84:22e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB995BB7;
        Fri, 12 May 2023 04:04:19 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 3B95440A6F; Fri, 12 May 2023 11:47:53 +0100 (BST)
Date:   Fri, 12 May 2023 11:47:53 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 02/14] Documentation/x86: Secure Launch kernel
 documentation
Message-ID: <20230512104753.GA14461@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-3-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-3-ross.philipson@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,KHOP_HELO_FCRDNS,SPF_HELO_NEUTRAL,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, May 04, 2023 at 02:50:11PM +0000, Ross Philipson wrote:
> +Secure Launch does not interoperate with KASLR. If possible, the MLE should be
> +built with KASLR disabled::

Why does Secure Launch not interoperate with KASLR?

Re: IOMMUs

> +It is recommended that no other command line options should be set to override
> +the defaults above.

What happens if they are? Does doing so change the security posture of 
the system? If so, will the measurements be different in a way that 
demonstrates the system is in an insecure state?


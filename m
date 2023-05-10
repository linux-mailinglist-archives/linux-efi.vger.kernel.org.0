Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC49B6FD37B
	for <lists+linux-efi@lfdr.de>; Wed, 10 May 2023 03:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbjEJBVs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 May 2023 21:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjEJBVs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 May 2023 21:21:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C29F211B;
        Tue,  9 May 2023 18:21:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17658616DA;
        Wed, 10 May 2023 01:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F214DC433EF;
        Wed, 10 May 2023 01:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683681706;
        bh=T+hNUKAHDe9/ZAR53PM2iZM4RaBimliyI1btNF2Jf4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WoPGVpnQuUFTlGuKZx2LN+aJQD2+DlIT5gCBC8mO4wyKgGinDHp4aovWaFaYexlKU
         Y6jnJsD/RGrgxlVqUKFSThnxS4m/bVDvO/cCrR6BFvcypk77gTyAydbmojrnFC/nPy
         wJzQQ6+mHSe0ggabvV7VKj7YdoFe2TkDI4Pt/oS43WyHFDtzqUp7//ER40IjBXvBgb
         eg0arAk5eTxvrnprmSO5QzZoHAs8wmVeCwtywD5ubsINReU32BkJZpg0UxCkGn99Z7
         11LRF/RhTZyO+rgagdAYPyMQygKom5LEW09j7fEMpSq2+s+V4f+YMyyQSbHBDvg0B2
         h+ZlBQRySDMAQ==
Date:   Tue, 9 May 2023 18:21:44 -0700
From:   Eric Biggers <ebiggers@kernel.org>
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
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
Message-ID: <20230510012144.GA1851@quark.localdomain>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-7-ross.philipson@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, May 04, 2023 at 02:50:15PM +0000, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> 
> The SHA algorithms are necessary to measure configuration information into
> the TPM as early as possible before using the values. This implementation
> uses the established approach of #including the SHA libraries directly in
> the code since the compressed kernel is not uncompressed at this point.
> 
> The SHA code here has its origins in the code from the main kernel:
> 
> commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
> 
> That code could not be pulled directly into the setup portion of the
> compressed kernel because of other dependencies it pulls in. The result
> is this is a modified copy of that code that still leverages the core
> SHA algorithms.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

SHA-1 is insecure.  Why are you still using SHA-1?  Don't TPMs support SHA-2
now?

And if you absolutely MUST use SHA-1 despite it being insecure, please at least
don't obfuscate it by calling it simply "SHA".

- Eric

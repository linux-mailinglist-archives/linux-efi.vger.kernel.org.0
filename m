Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24A44AD4D9
	for <lists+linux-efi@lfdr.de>; Tue,  8 Feb 2022 10:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353240AbiBHJ2f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Feb 2022 04:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbiBHJ2e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Feb 2022 04:28:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E643CC03FEC0;
        Tue,  8 Feb 2022 01:28:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81C35614C4;
        Tue,  8 Feb 2022 09:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAC7C004E1;
        Tue,  8 Feb 2022 09:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644312511;
        bh=xg6lF3WqgMKyMC4n+ayD5APVx6cp2PqDNjyejBcqeJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uqOPs70ARuits274PJBtl8AYteGVMbp1Q+Rcn46o0mE+MQ1hmG2FguFczvPl5d7/i
         /TESayuhRAd1GIqhCiJIn2nkiZ70wMp3Vk/JkRr6hERDIyhpjuljH1MyzZft6uUzxO
         7lNnEwWQ+3W+ZRKUaVcLlArJSQl9DxA/W4hL0eNF/lQcXLL1JxrI0nHDVTXgR6kiVK
         et5vFWP7sG3fEO1CRvAc4tHHnFmC0FpppfFWZTTVfPOxoLOef/cw+AyUlZPItgecUL
         GlTPzZXiL1HwAYzRQGbON1NkCwL7sVvjBXbbwVop09qk0OdM/7RV+hRA+bkYki8ZQ9
         JMbC9rhwzp1zQ==
Date:   Tue, 8 Feb 2022 10:28:56 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>, dhowells@redhat.com,
        dwmw2@infradead.org, ardb@kernel.org, jmorris@namei.org,
        serge@hallyn.com, nayna@linux.ibm.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v10 0/8] Enroll kernel keys thru MOK
Message-ID: <YgI32LAFgGSW6ugh@iki.fi>
References: <20220126025834.255493-1-eric.snowberg@oracle.com>
 <YfFP6OHqBVNWKL2C@iki.fi>
 <YfFTf6vIpNMIrwH0@iki.fi>
 <78d2c13ad60b5f845cb841d257d1b41290f575c6.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78d2c13ad60b5f845cb841d257d1b41290f575c6.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 26, 2022 at 05:06:09PM -0500, Mimi Zohar wrote:
> Hi Jarkko,
> 
> > > Thank you. I'll pick these soon. Is there any objections?
> 
> No objections.
> > 
> > Mimi brought up that we need a MAINTAINERS update for this and also
> > .platform.
> > 
> > We have these:
> > 
> > - KEYS/KEYRINGS
> > - CERTIFICATE HANDLING
> > 
> > I would put them under KEYRINGS for now and would not consider further
> > subdivision for the moment.
> 
> IMA has dependencies on the platform_certs/ and now on the new .machine
> keyring.  Just adding "F: security/integrity/platform_certs/" to the
> KEYS/KEYRINGS record, ignores that dependency.  The discussion wouldn't
> even be on the linux-integrity mailing list.
> 
> Existing requirement:
> - The keys on the .platform keyring are limited to verifying the kexec
> image.
> 
> New requirements based on Eric Snowbergs' patch set:
> - When IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is enabled,
> the MOK keys will not be loaded directly onto the .machine keyring or
> indirectly onto the .secondary_trusted_keys keyring.
> 
> - Only when a new IMA Kconfig explicitly allows the keys on the
> .machine keyrings, will the CA keys stored in MOK be loaded onto the
> .machine keyring.
> 
> Unfortunately I don't think there is any choice, but to define a new
> MAINTAINERS entry.  Perhaps something along the lines of:
> 
> KEYS/KEYRINGS_INTEGRITY
> M:     Jarkko Sakkinen <jarkko@kernel.org>
> M:     Mimi Zohar <zohar@linux.ibm.com>
> L:      keyrings@vger.kernel.org
> L:      linux-integrity@vger.kernel.org
> F:      security/integrity/platform_certs

WFM. BTW, the patches are now in my tree:

git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git

I can add any tags requested. I'll mirror this at some point to linux-next.

/Jarkko

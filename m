Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98714BD0C5
	for <lists+linux-efi@lfdr.de>; Sun, 20 Feb 2022 20:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243303AbiBTTAX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 20 Feb 2022 14:00:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbiBTTAX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 20 Feb 2022 14:00:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70BC4C797;
        Sun, 20 Feb 2022 11:00:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71EDC60EBD;
        Sun, 20 Feb 2022 19:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64140C340E8;
        Sun, 20 Feb 2022 19:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645383600;
        bh=hLGifkqFozZGhUf8MjlDCOo+prHzRXakxzvfzWvrn4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DP/88MqofASXWs0Y+BU+/Lcgls+cRDsofuRs/jYeoX5djirvCV2YVEsFTcgtuTXGC
         HeNmJrBkpP+LZhsPuBb+jmo5hu0t4J7QH/V49lmpnd8P0NMq2C4PyRBM4OfTFCulFd
         AV0+pPW9Iul6HTzZB9Rf/ml64Ym4zAdHtZXs0XpGq3YjbWDeuT7QMXyYK0Cfz2e92x
         1C2puHEDUNPg4kB9caiNtmQzvqhatOGffMI0fS4ugKR8nwY8dP73va8NXTsUJPvM88
         kjI8nEfSX4nnQcJmL2kF4W7tEPgcmVS0lfXxbOxv3lcgesaRf83jI+0/BOZtaq5Md4
         ZWcVGXwBnribQ==
Date:   Sun, 20 Feb 2022 20:00:39 +0100
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
Message-ID: <YhKP12KEmyqyS8rj@iki.fi>
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
> 
> thanks,
> 
> Mimi

This would work for me.

BR, Jarkko

Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D4850F887
	for <lists+linux-efi@lfdr.de>; Tue, 26 Apr 2022 11:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241916AbiDZJPy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Apr 2022 05:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347887AbiDZJO7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Apr 2022 05:14:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF0418C471;
        Tue, 26 Apr 2022 01:52:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9BC9D1F380;
        Tue, 26 Apr 2022 08:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650963141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q9x48+GCsfx8UTJooQHuN3co/8645ibddxEq5xzH/f0=;
        b=yZAvKIvoIMj/C8AP23Sgip2C72RyAhmfCGURC5EmsDATIEEbmcTjCMr+5vNPDW7nXL4IDr
        RZS5hN3NDlSmSC7KZmxgh0Q8+ebajiyLfcqCBuxyFAtAuk+JqnCyYkZqRqpDEjqNk2wQvb
        SKB0lwW8mxkThtwtw7IHoN2ElKj716w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650963141;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q9x48+GCsfx8UTJooQHuN3co/8645ibddxEq5xzH/f0=;
        b=giElD4sntmpyBe4F+XJ7JwX+63DS/bvCsQrP7DFkNJT51AmyejoqK0FthrZ4dyZWLMA9OM
        UJSMBqiHWoFOqaAQ==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7FB0A2C17E;
        Tue, 26 Apr 2022 08:52:21 +0000 (UTC)
Date:   Tue, 26 Apr 2022 10:52:20 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     "Guozihua (Scott)" <guozihua@huawei.com>
Cc:     "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: How to list keys used for kexec
Message-ID: <20220426085220.GE163591@kunlun.suse.cz>
References: <20220414175930.GM163591@kunlun.suse.cz>
 <853635d6-9e74-c3dc-f6dc-d4166616c8e5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <853635d6-9e74-c3dc-f6dc-d4166616c8e5@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Apr 26, 2022 at 12:10:13PM +0800, Guozihua (Scott) wrote:
> On 2022/4/15 1:59, Michal Suchánek wrote:
> > Hello,
> > 
> > apparently modules are verified by keys from 'secondary' keyring on all
> > platforms.
> > 
> > If you happen to know that it's this particular keyring, and know how
> > to list keyrings recursively you can find the keys that are used for
> > verifying modules.
> > 
> > However, for kexec we have
> > 
> >   - primary keyring on aarch64
> >   - platform keyring on s390
> >   - secondary AND platform keyring on x86
> > 
> > How is a user supposed to know which keys are used for kexec image
> > verification?
> > 
> > There is an implicit keyring that is ad-hoc constructed by the code that
> > does the kexec verification but there is no key list observable from
> > userspace that corresponds to this ad-hoc keyring only known to the kexec
> > code.
> > 
> > Can the kernel make the information which keys are used for what purpose
> > available to the user?
> > 
> > Thanks
> > 
> > Michal
> > 
> > .
> 
> Hi Michal
> 
> I'll try my best to understand and answer your question.
> 
> First of all, the "key" you mentioned here is actually certificate. And
> there are no way for the kernel to know "which certificate is used for what
> purpose" but to get a hint from the certificate's extension, if they exist.
> However, the extension only points out what this certificate should be used
> for, but not exactly what it is actually used for.

> Secondly, the verification process requires the module (kernel image in this
> question) to contain information on which certificate should be used to
> verify itself. The signature provided by the module is in PKCS#7 format
> which contains a list of certificates for the verifier to construct a "chain
> of trust". Each certificates contains information pointing to the
> certificate of it's issuer, and eventually to one of the certificate stored
> in one of the keyrings you mentioned.

Indeed, that's not really relevant to this problem.
Sure, if the certificates extension does exist and does not state that
the certificate can be used for code signing then the signature should
be rejected. The same if the signature is malformed and does not provide
enough information to determine which key was used to create it.

The question which key will be checked, though.
> 
> All in all, certificates in these keyrings you mentioned can be used for
> various purpose, and it's the responsibility for the modules being verified
> to provide information stating which certificate should be used for
> verification. Thus, the best way to find out which key is used for kexec is
> to look at key used to sign the kernel image.

There aren't really good tools for working with the kernel signatures
but I can tell what certificate it was signed with jumping throught some
hoops.

What I can't tell without reading the kernel code (different for each
architecture) is what certificates the kernel considers valid for
signing kernels. The kernel surely knows but does not tell.

That is, for example, if I have a known bad kernel I want to be able to
tell if it's loadable without actually loading it.

Thanks

Michal

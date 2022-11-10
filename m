Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524E66245D2
	for <lists+linux-efi@lfdr.de>; Thu, 10 Nov 2022 16:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiKJP23 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Nov 2022 10:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiKJP1e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Nov 2022 10:27:34 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D980B3F054;
        Thu, 10 Nov 2022 07:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1668094051;
        bh=JR33g8gWlSZGidJuKivTgbq5ECjLpcLYApf6iPOEG4w=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ud4jobt2vwD795E+KzwUN6dmloAtvJnv237I9aQOWFlYSMugYNh7X/5QAlOgP10Hw
         shu82adBq6GPRCVeMKyQKWc7fHBmWgCS+dl6RZAEZMjSrGlICLe3hXbsAj5U3E4A49
         jeahL4oHCgMKm6FdvPgIzjko01lbA5wDSJ/TplKs=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AD6DB1285F6D;
        Thu, 10 Nov 2022 10:27:31 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P-df-yN8V5IA; Thu, 10 Nov 2022 10:27:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1668094050;
        bh=JR33g8gWlSZGidJuKivTgbq5ECjLpcLYApf6iPOEG4w=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=kq+CmaEP+hl8WK8iJn9Oiow8bNpyykjPeEzKJebMmy/YDGGGCRfa/FFR9L9H+DrKr
         OgD9kxYnHQuyo4RNMN7ZekqaOIo3H7NOno1DhnPjA/zuHmTjbtBq520z4p4x7u4qnx
         DZ5fiNQES6FbjQUxUXmOxwmdo60xLLqodNtdeK+k=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0026C1286591;
        Thu, 10 Nov 2022 10:27:27 -0500 (EST)
Message-ID: <47ae05f8d3a67ee5e1607ab8e718cc4b3e95cebb.camel@HansenPartnership.com>
Subject: Re: [PATCH v8 16/17] integrity: Trust MOK keys if MokListTrustedRT
 found
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Morten Linderud <morten@linderud.pw>,
        Eric Snowberg <eric.snowberg@oracle.com>
Cc:     "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Biggers <ebiggers@google.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "lszubowi@redhat.com" <lszubowi@redhat.com>,
        "jason@zx2c4.com" <jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "pjones@redhat.com" <pjones@redhat.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Date:   Thu, 10 Nov 2022 10:27:24 -0500
In-Reply-To: <20221110150607.h4iaymkgc4f7kuue@framework>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
         <20211124044124.998170-17-eric.snowberg@oracle.com>
         <20221110000129.kl6pjy5mafpuptbk@framework>
         <4A479B96-4B41-4323-9920-5A909423F998@oracle.com>
         <20221110150607.h4iaymkgc4f7kuue@framework>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2022-11-10 at 16:06 +0100, Morten Linderud wrote:
> I'm not really sure what Peter means with "much more reliable"
> though.

It's that in-head knowledge you referred to.  You can't see the true
MoK variables because they're BootServices, meaning they're not visible
in the RunTime, which is why the shadow RT variables exist (this is a
security property: BS only variables can only be altered by trusted,
signed entities).  However lots of things can create RT variables so
you have to run through a sequence of checks on the RT shadows to try
to defeat clever attackers (like verifying the variable attributes),
because the chain of custody from BS to RT is not guaranteed.  If you
use a configuration table instead, that is BS only, the kernel (which
is also a trusted entity) has to pick it out before ExitBootServices,
so if the kernel has the table, you have a reliable chain of custody
for the entries.

James


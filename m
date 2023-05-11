Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC6B6FEA3B
	for <lists+linux-efi@lfdr.de>; Thu, 11 May 2023 05:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjEKDed (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 May 2023 23:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEKDec (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 10 May 2023 23:34:32 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A682D64;
        Wed, 10 May 2023 20:34:28 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pwx3z-007Ytd-Ii; Thu, 11 May 2023 11:33:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 May 2023 11:33:56 +0800
Date:   Thu, 11 May 2023 11:33:56 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
Message-ID: <ZFxiJF373HCwZLKE@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-7-ross.philipson@oracle.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.doc,apana.lists.os.linux.kernel
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ross Philipson <ross.philipson@oracle.com> wrote:
>
> +static void __sha_transform(u32 *digest, const char *data)
> +{
> +       u32 ws[SHA1_WORKSPACE_WORDS];
> +
> +       sha1_transform(digest, data, ws);
> +
> +       memzero_explicit(ws, sizeof(ws));
> +}
> +
> +void early_sha1_init(struct sha1_state *sctx)
> +{
> +       sha1_init(sctx->state);
> +       sctx->count = 0;
> +}
> +
> +void early_sha1_update(struct sha1_state *sctx,
> +                      const u8 *data,
> +                      unsigned int len)
> +{
> +       unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
> +
> +       sctx->count += len;
> +
> +       if (likely((partial + len) >= SHA1_BLOCK_SIZE)) {
> +               int blocks;
> +
> +               if (partial) {
> +                       int p = SHA1_BLOCK_SIZE - partial;
> +
> +                       memcpy(sctx->buffer + partial, data, p);
> +                       data += p;
> +                       len -= p;
> +
> +                       __sha_transform(sctx->state, sctx->buffer);
> +               }
> +
> +               blocks = len / SHA1_BLOCK_SIZE;
> +               len %= SHA1_BLOCK_SIZE;
> +
> +               if (blocks) {
> +                       while (blocks--) {
> +                               __sha_transform(sctx->state, data);
> +                               data += SHA1_BLOCK_SIZE;
> +                       }
> +               }
> +               partial = 0;
> +       }
> +
> +       if (len)
> +               memcpy(sctx->buffer + partial, data, len);
> +}
> +
> +void early_sha1_final(struct sha1_state *sctx, u8 *out)
> +{
> +       const int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
> +       unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
> +       __be64 *bits = (__be64 *)(sctx->buffer + bit_offset);
> +       __be32 *digest = (__be32 *)out;
> +       int i;
> +
> +       sctx->buffer[partial++] = 0x80;
> +       if (partial > bit_offset) {
> +               memset(sctx->buffer + partial, 0x0, SHA1_BLOCK_SIZE - partial);
> +               partial = 0;
> +
> +               __sha_transform(sctx->state, sctx->buffer);
> +       }
> +
> +       memset(sctx->buffer + partial, 0x0, bit_offset - partial);
> +       *bits = cpu_to_be64(sctx->count << 3);
> +       __sha_transform(sctx->state, sctx->buffer);
> +
> +       for (i = 0; i < SHA1_DIGEST_SIZE / sizeof(__be32); i++)
> +               put_unaligned_be32(sctx->state[i], digest++);
> +
> +       *sctx = (struct sha1_state){};
> +}

If we're going to add SHA1 then this should go into lib/crypto
just like SHA2.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

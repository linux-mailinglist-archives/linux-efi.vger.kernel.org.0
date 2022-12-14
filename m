Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBFC64D1EC
	for <lists+linux-efi@lfdr.de>; Wed, 14 Dec 2022 22:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiLNVnf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Dec 2022 16:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiLNVn0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 14 Dec 2022 16:43:26 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1846C31DE8;
        Wed, 14 Dec 2022 13:43:24 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 18C2E300097BD;
        Wed, 14 Dec 2022 22:43:21 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 0C12910A68; Wed, 14 Dec 2022 22:43:21 +0100 (CET)
Date:   Wed, 14 Dec 2022 22:43:21 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Florian Weimer <fweimer@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efitools: Include <strings.h> for the strcasecmp function
Message-ID: <20221214214321.GA23425@wunner.de>
References: <87pmcllll9.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmcllll9.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

[+cc James]

On Wed, Dec 14, 2022 at 10:30:26PM +0100, Florian Weimer wrote:
> Otherwise, an implicit function declaration is the result, and the
> code may fail to compile with future compilers.
> 
> ---
>  efi-updatevar.c | 1 +
>  1 file changed, 1 insertion(+)

efitools appears to be maintained by James, so you may want to cc
your submissions to him.

Your patches are missing a DCO, yet existing commits in the efitools
repository have one.  You may want to respin with your Signed-off-by
added.

Thanks,

Lukas

> 
> diff --git a/efi-updatevar.c b/efi-updatevar.c
> index 4247105..033d938 100644
> --- a/efi-updatevar.c
> +++ b/efi-updatevar.c
> @@ -11,6 +11,7 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include <strings.h>
>  #include <sys/stat.h>
>  #include <fcntl.h>
>  #include <unistd.h>
> 
> Related to:
> 
>   <https://fedoraproject.org/wiki/Changes/PortingToModernC>
>   <https://fedoraproject.org/wiki/Toolchain/PortingToModernC>
> 

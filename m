Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39D52E0E9A
	for <lists+linux-efi@lfdr.de>; Wed, 23 Oct 2019 01:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389726AbfJVXim (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Oct 2019 19:38:42 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35347 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732854AbfJVXim (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 22 Oct 2019 19:38:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46yVM30KZ7z9sP3;
        Wed, 23 Oct 2019 10:38:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1571787519;
        bh=ami4f9vYKglFSg2kDdmqUNRGc0PgB16FBNgszZYiGT8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iJS0BO5Zt/5UnZpboy9Fexepcv5UxfOTmUBHzEbwB/BblzxTYNspikCD5UaCMR91e
         f15rhAPDNUBW6y4Tor1tzB4i77fVRALpb+PgigrOTkMVHa+fLDz6+teRjwks8R2K4H
         BA3jub/ckFJsXyIIybAF0gIbX7nsDILWm6ncQ4PGN6N0MSZ2C1r69Aj3sigiDO+5h7
         MsBi7VOWstM54ck9npR7g7Wfo7iru0Ovs8QwCVdCbtR4OyLbOlonmHCazRoiHaeLeO
         p6OcrSNJoTAmwzTF55V8Tax4wHJ1+SWFIfY/bWTPzDZFBdJDXxofABlAUaB2BijTsE
         nJNwdofapNTKw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: Re: [PATCH v8 3/8] powerpc: detect the trusted boot state of the system
In-Reply-To: <1571508377-23603-4-git-send-email-nayna@linux.ibm.com>
References: <1571508377-23603-1-git-send-email-nayna@linux.ibm.com> <1571508377-23603-4-git-send-email-nayna@linux.ibm.com>
Date:   Wed, 23 Oct 2019 10:38:38 +1100
Message-ID: <87wocw5p1d.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Nayna Jain <nayna@linux.ibm.com> writes:
> diff --git a/arch/powerpc/kernel/secure_boot.c b/arch/powerpc/kernel/secure_boot.c
> index 99bba7915629..9753470ab08a 100644
> --- a/arch/powerpc/kernel/secure_boot.c
> +++ b/arch/powerpc/kernel/secure_boot.c
> @@ -28,3 +39,16 @@ bool is_ppc_secureboot_enabled(void)
>  	pr_info("Secure boot mode %s\n", enabled ? "enabled" : "disabled");
>  	return enabled;
>  }
> +
> +bool is_ppc_trustedboot_enabled(void)
> +{
> +	struct device_node *node;
> +	bool enabled = false;
> +
> +	node = get_ppc_fw_sb_node();
> +	enabled = of_property_read_bool(node, "trusted-enabled");

Also here you need:

	of_node_put(node);

> +
> +	pr_info("Trusted boot mode %s\n", enabled ? "enabled" : "disabled");
> +
> +	return enabled;
> +}

cheers

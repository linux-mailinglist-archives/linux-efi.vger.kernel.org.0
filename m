Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D18D1E0E94
	for <lists+linux-efi@lfdr.de>; Wed, 23 Oct 2019 01:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732805AbfJVXhe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Oct 2019 19:37:34 -0400
Received: from ozlabs.org ([203.11.71.1]:50863 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731847AbfJVXhe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 22 Oct 2019 19:37:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46yVKk41tlz9sP3;
        Wed, 23 Oct 2019 10:37:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1571787451;
        bh=bix38GBS8ziIG4D3rYTWk0p86PfmiZSj/wSR65+5FO4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UGBdAfxatgCtF86fvylV99/QFpSVym95XuNMX9oU9VJ/vdOXEBZnaKPrE+RU4NoEa
         LF4vXTA63Y1NCPpdUeNamISsqi58pKjanBzbMC5w+mv6Tf55QMI+2wCFqXK2Syjo0T
         NQRBGiuxA5ZKAKARmotaog3inA58Mk1hdtXTzKoRfpM4ptLFMTepUmJaIz6VGujCMr
         JvoS89CZDSyjig9lE0RuwgLNyYRbrS4GtsUYs+PjySDB7MIt+fV+Zb0KTe5Bs9Rj1X
         k04YauMfnuq75MflrBRrXCE6uOEpH6Hg+o/k4rkuDybV3a0E+QhbYmFBBHmGJtAzBC
         spPt9ZtqKX6Bw==
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
Subject: Re: [PATCH v8 1/8] powerpc: detect the secure boot mode of the system
In-Reply-To: <1571508377-23603-2-git-send-email-nayna@linux.ibm.com>
References: <1571508377-23603-1-git-send-email-nayna@linux.ibm.com> <1571508377-23603-2-git-send-email-nayna@linux.ibm.com>
Date:   Wed, 23 Oct 2019 10:37:30 +1100
Message-ID: <87zhhs5p39.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Nayna Jain <nayna@linux.ibm.com> writes:
> diff --git a/arch/powerpc/kernel/secure_boot.c b/arch/powerpc/kernel/secure_boot.c
> new file mode 100644
> index 000000000000..99bba7915629
> --- /dev/null
> +++ b/arch/powerpc/kernel/secure_boot.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 IBM Corporation
> + * Author: Nayna Jain
> + */
> +#include <linux/types.h>
> +#include <linux/of.h>
> +#include <asm/secure_boot.h>
> +
> +bool is_ppc_secureboot_enabled(void)
> +{
> +	struct device_node *node;
> +	bool enabled = false;
> +
> +	node = of_find_compatible_node(NULL, NULL, "ibm,secvar-v1");

If this found a node then you have a node with an elevated refcount
which you need to drop on the way out.

> +	if (!of_device_is_available(node)) {
> +		pr_err("Cannot find secure variable node in device tree; failing to secure state\n");
> +		goto out;
> +	}
> +
> +	/*
> +	 * secureboot is enabled if os-secure-enforcing property exists,
> +	 * else disabled.
> +	 */
> +	enabled = of_property_read_bool(node, "os-secure-enforcing");
> +
> +out:

So here you need:

	of_node_put(node);


> +	pr_info("Secure boot mode %s\n", enabled ? "enabled" : "disabled");
> +	return enabled;
> +}

cheers

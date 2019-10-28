Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E32CE6D43
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2019 08:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbfJ1HaM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Oct 2019 03:30:12 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:59370 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730235AbfJ1HaM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Oct 2019 03:30:12 -0400
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl-tcp.brodo.linta [10.1.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id A4040200A0D;
        Mon, 28 Oct 2019 07:30:09 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 5866A801A8; Mon, 28 Oct 2019 08:20:36 +0100 (CET)
Date:   Mon, 28 Oct 2019 08:20:36 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        mario.limonciello@dell.com
Cc:     linux-efi@vger.kernel.org
Subject: efistub: EFI_RNG_PROTOCOL on Dell Inc. Latitude 7390
Message-ID: <20191028072036.GA113601@owl.dominikbrodowski.net>
References: <20191005113753.GA77634@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005113753.GA77634@light.dominikbrodowski.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ard, Mario,

in theory, invoking EFI_RNG_PROTOCOL on a Dell Inc. Latitude 7390/09386V,
BIOS 1.9.2 04/03/2019, should work fine as the system provides EFI v2.60.
Using my patch from a few weeks ago[1], efi_random_get_seed() is called from
arch/x86/boot/compressed/eboot.c::efi_main(). In efi_random_get_seed(), the
calls to

	status = efi_call_early(locate_protocol, &rng_proto, NULL,
				(void **)&rng);

and

	status = efi_call_early(allocate_pool, EFI_RUNTIME_SERVICES_DATA,
				sizeof(*seed) + EFI_RANDOM_SEED_SIZE,
				(void **)&seed);

succeed. However,

	status = rng->get_rng(rng, &rng_algo_raw, EFI_RANDOM_SEED_SIZE,
			      seed->bits);

returns EFI_INVALID_PARAMETER, though I can't see why one of these
parameters is invalid. When trying to use the default rng algorithm (by
modifying the test to "(status != EFI_SUCCESS)"),

		status = rng->get_rng(rng, NULL, EFI_RANDOM_SEED_SIZE,
				      seed->bits);

the call doesn't seem to return.

Any ideas?

Best,
	Dominik


[1] https://lore.kernel.org/lkml/20191005113753.GA77634@light.dominikbrodowski.net/

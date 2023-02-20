Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A0A69D0FA
	for <lists+linux-efi@lfdr.de>; Mon, 20 Feb 2023 16:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjBTPxr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Feb 2023 10:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjBTPxg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Feb 2023 10:53:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEDFCC10
        for <linux-efi@vger.kernel.org>; Mon, 20 Feb 2023 07:53:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAAE5B80D3D
        for <linux-efi@vger.kernel.org>; Mon, 20 Feb 2023 15:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B2FC433D2;
        Mon, 20 Feb 2023 15:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676908412;
        bh=q+UVYAvOaKZ6rZqbBNYvveBTTXN21i0MHtTIbAuaZpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lR09TSNkGgYv6pu7RULT1Zz3+OmsbCIoNTVNVZyX2foLFHw9Drn9v6q0Tp1lbMUAM
         qCDSqe36uqeS5OF+j2nWNoqB8QfErP40SiEvXuV1644x/DGih07R9MtQ0J5oPiT58E
         nrHhPr9CX+mdMBrySoxSAQZTWBd+hJ5Hmyub6wEr1bzVqJXrIAcbhc4jgXoPiUn/CV
         mepLTTlzV4r4N24lWIXnGvvfPJRA0vHR0kvDaJpTXQqK30fL/N5AaZtQUsM0ZvrZQA
         wN2NeWUyN4yalD6BwUi6qCYe94J7F2iwD27y/AgvW5HIhVqZdU+c7nCQyA/hQ6gNxB
         aAKOlH4nxkR2A==
Date:   Mon, 20 Feb 2023 15:53:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 2/3] efi: arm64: Wire up BTI annotation in memory
 attributes table
Message-ID: <Y/OXdpfcsoPxgHdq@sirena.org.uk>
References: <20230206124938.272988-1-ardb@kernel.org>
 <20230206124938.272988-3-ardb@kernel.org>
 <20230208130007.GA13529@willie-the-truck>
 <CAMj1kXEReR30NYgHS67W2RH0z=0HdG4UrkBKuTXwFN9NrNE6wg@mail.gmail.com>
 <Y+Owvx0e24gZb7hy@FVFF77S0Q05N.cambridge.arm.com>
 <CAMj1kXG5iG=ok_nWnt7Tj5-Evwen4VvOQoNpVHh5mPU2mbCDWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5WpvdvFpmWSYyolJ"
Content-Disposition: inline
In-Reply-To: <CAMj1kXG5iG=ok_nWnt7Tj5-Evwen4VvOQoNpVHh5mPU2mbCDWQ@mail.gmail.com>
X-Cookie: Adapt.  Enjoy.  Survive.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--5WpvdvFpmWSYyolJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 08, 2023 at 03:36:40PM +0100, Ard Biesheuvel wrote:

> OTOH, what is the penalty for setting the GP attribute and using the
> translation table on a core that does not implement BTI?

The concern with doing that for Linux was what would happen if someone
implemented a system with mixed BTI/no BTI support and then a task got
preempted and moved between the two, you might end up with PSTATE.BTYPE
incorrectly set and trigger a spurious fault.  That shouldn't be an
issue for EFI runtime services.

--5WpvdvFpmWSYyolJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPzl3UACgkQJNaLcl1U
h9DULQf/W0cn39PdHYc9sdljFWeJ7LRx3yvPMxJ8y2zgfUJtLtJjOVUy9btE3o8D
mTepWDY6AQwhxlj3wGa3T11dKw1/f8OKnw1s9PiNCYCDMU9D8gRssCMf02X+FPQI
bFX+lYkl/MvC6CG+5sbdn8LWKqIOShEDkHuAYu8CPiUr4vuy5rgJN0XdUcNeYsul
Bl6ERMhjSKyJUtGZVK/8U1sfi9gU582K8ZJjAYdHjxKmo9lxMpA6Leo5UbBVi432
bN+2tgdhiw6LXrGjN4sfRcsLn1BMng3YJPSiJbKqJgo8OQJDHj0wk+CMhyUpax9w
RmJJPxXTKizu8hnEHdM64QlkG9JE3g==
=GcCt
-----END PGP SIGNATURE-----

--5WpvdvFpmWSYyolJ--

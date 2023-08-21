Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348D6782708
	for <lists+linux-efi@lfdr.de>; Mon, 21 Aug 2023 12:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbjHUKZJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Aug 2023 06:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjHUKZJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 21 Aug 2023 06:25:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88E313E
        for <linux-efi@vger.kernel.org>; Mon, 21 Aug 2023 03:24:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEBF163007
        for <linux-efi@vger.kernel.org>; Mon, 21 Aug 2023 10:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF5BC433C7;
        Mon, 21 Aug 2023 10:24:21 +0000 (UTC)
Date:   Mon, 21 Aug 2023 11:24:19 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 02/11] efi/arm64: Move EFI runtime call setup/teardown
 helpers out of line
Message-ID: <ZOM7U0v9ibeBLC+O@arm.com>
References: <20230818113724.368492-1-ardb@kernel.org>
 <20230818113724.368492-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818113724.368492-3-ardb@kernel.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 18, 2023 at 01:37:15PM +0200, Ard Biesheuvel wrote:
> Only the arch_efi_call_virt() macro that some architectures override
> needs to be a macro, given that it is variadic and encapsulates calls
> via function pointers that have different prototypes.
> 
> The associated setup and teardown code are not special in this regard,
> and don't need to be instantiated at each call site. So turn them into
> ordinary C functions and move them out of line.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

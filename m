Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428213067E4
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jan 2021 00:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhA0X3l (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Jan 2021 18:29:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233679AbhA0X23 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 Jan 2021 18:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611790023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UmZtO9S6cUQ2CC3kIdExR5VZtUZQ7YeAA3zNA2d3Y68=;
        b=V5Hf+EOsAZRBIwUwUvGVXehgBzfCp1Gf5G+xVqGPNklmZ69PNoEEnmet9tBbpUcv4BLFsS
        7T1p9AzDDYNOaDWe+dUg22cNpu3XxYb4uUNsSXrNYFaVOQwPwDVfeci4CnTIVzibYlSioy
        w+UJtwVrowqc8Wf6MZRLxRouwsoPfV0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-yX2crCwSMlywEzTRrvJlVw-1; Wed, 27 Jan 2021 18:27:00 -0500
X-MC-Unique: yX2crCwSMlywEzTRrvJlVw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25DAC911E3;
        Wed, 27 Jan 2021 23:26:57 +0000 (UTC)
Received: from treble (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6681D10016FA;
        Wed, 27 Jan 2021 23:26:53 +0000 (UTC)
Date:   Wed, 27 Jan 2021 17:26:51 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     jthierry@redhat.com, ardb@kernel.org, broonie@kernel.org,
        catalin.marinas@arm.com, keescook@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, peterz@infradead.org,
        raphael.gault@arm.com, will@kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [RFC PATCH 12/17] gcc-plugins: objtool: Add plugin to detect
 switch table on arm64
Message-ID: <20210127232651.rj3mo7c2oqh4ytsr@treble>
References: <20210120173800.1660730-13-jthierry@redhat.com>
 <20210127221557.1119744-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210127221557.1119744-1-ndesaulniers@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 27, 2021 at 02:15:57PM -0800, Nick Desaulniers wrote:
> > From: Raphael Gault <raphael.gault@arm.com>
> > 
> > This plugins comes into play before the final 2 RTL passes of GCC and
> > detects switch-tables that are to be outputed in the ELF and writes
> > information in an ".discard.switch_table_info" section which will be
> > used by objtool.
> > 
> > Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> > [J.T.: Change section name to store switch table information,
> >        Make plugin Kconfig be selected rather than opt-in by user,
> >        Add a relocation in the switch_table_info that points to
> >        the jump operation itself]
> > Signed-off-by: Julien Thierry <jthierry@redhat.com>
> 
> Rather than tightly couple this feature to a particular toolchain via
> plugin, it might be nice to consider what features could be spec'ed out
> for toolchains to implement (perhaps via a -f flag).

The problem is being able to detect switch statement jump table vectors.

For a given indirect branch (due to a switch statement), what are all
the corresponding jump targets?

We would need the compiler to annotate that information somehow.

> Distributions (like Android, CrOS) wont be able to use such a feature as
> is.

Would a Clang plugin be out of the question?

-- 
Josh


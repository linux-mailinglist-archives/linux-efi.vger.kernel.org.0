Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E571E516F
	for <lists+linux-efi@lfdr.de>; Thu, 28 May 2020 00:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbgE0WrB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 May 2020 18:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE0WrB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 May 2020 18:47:01 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0112AC05BD1E;
        Wed, 27 May 2020 15:47:00 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f18so1375363qkh.1;
        Wed, 27 May 2020 15:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hdWbjQHS/5LC948mUM96MFEQV/j+JyYYxwWuAAvmOdE=;
        b=cdUhXoam5HnhNHy1GFB1tDHea0+fM9C0n6OJgl+9wuCWxKRLL2breGo7/8R8LEj778
         oqP9jhx8v0q8fEpw2+KETcWZB2j8cBm3ThoTTb8s2Nr+oPGJQFv4HdlzOGKaomeSfTU/
         DUMfb0iX0RnCk28R0/64IZsaEf69+OMAHTGRd26BoRg8JTbJnHN4ra3dMQPJXkkFbDpf
         8JaNlU2bXBdnYB6OIqscrXItVJyK0pWhDKNaFZhPRbCPazRJ+50pX0gJ1Ee0IgK5PvVK
         88ewrnarGeQPtOgbV6xkfsSzPuXr6t8IDBxEAtRg505voz5SADloB0h/taSopxAgjbI+
         w60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=hdWbjQHS/5LC948mUM96MFEQV/j+JyYYxwWuAAvmOdE=;
        b=iazVMkP4K6qjC1RdHp+V3I5zedO0RT/+RDcAOkB6CXXtaxKY2j+Cr57/WHe7Durc94
         jxj4SEPf8dPGJkpo81ZHJkLLfFlQnAQhM9Y+k5bSmcW0lmMzet0RQPCpzg1oHj6onnFi
         l3hb54aVYqrKHOCbM0M7+DJ/mP4UFSt+8uShUTlqDY78PzpHubUjZz3dWYrF06nZwcfw
         sgzN/0ZH2P4L0I716tI0bQns1je/N7JWRxeooxyTrAEOU6Wk+J3qlLtY+cHtp7Ug2bPN
         B81w4jyS4s8gm7dWdi/AmVXYtFJj4M3eycvPYGgm6rUoTgpGGH7nIM7LYTg9PIVNejlO
         KDxA==
X-Gm-Message-State: AOAM53195KVXyqjvwbVJ6wlaZY8VqlG6uld1lsx8p/OxsTJMNLhD+KhV
        r5LSi00C34Hytov55CXryOI=
X-Google-Smtp-Source: ABdhPJyFLWVeaWq2hvIIZQy/y7YZrHPrjOAiZAJCaQJDHjnLxleEPaZCb3y6Xm+spRDkflSJ8Ol4Eg==
X-Received: by 2002:a37:7603:: with SMTP id r3mr86393qkc.243.1590619620116;
        Wed, 27 May 2020 15:47:00 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y185sm2970856qkd.83.2020.05.27.15.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 15:46:59 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 27 May 2020 18:46:57 -0400
To:     "Williams, Dan J" <dan.j.williams@intel.com>
Cc:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "joe@perches.com" <joe@perches.com>,
        "nivedita@alum.mit.edu" <nivedita@alum.mit.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH 08/15] efi/x86: Move command-line initrd loading to
 efi_main
Message-ID: <20200527224657.GA3568142@rani.riverdale.lan>
References: <20200508180157.1816-1-ardb@kernel.org>
 <20200508180157.1816-9-ardb@kernel.org>
 <10a1c7fcea861f5d45dff81cba673e970d686bc2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10a1c7fcea861f5d45dff81cba673e970d686bc2.camel@intel.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 27, 2020 at 10:30:18PM +0000, Williams, Dan J wrote:
> On Fri, 2020-05-08 at 20:01 +0200, Ard Biesheuvel wrote:
> > From: Arvind Sankar <nivedita@alum.mit.edu>
> > 
> > Consolidate the initrd loading in efi_main.
> > 
> > The command line options now need to be parsed only once.
> > 
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Link: 
> > https://lore.kernel.org/r/20200430182843.2510180-9-nivedita@alum.mit.edu
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> 
> Hi,
> 
> This patch patch in tip/master as:
> 
> 987053a30016 efi/x86: Move command-line initrd loading to efi_main
> 
> ...regresses my nfs root configuration. It hangs trying to mount the
> nfs root filesystem "root=/dev/nfs ip=dhcp".
> 
> It does not revert cleanly.
> 
> 

Does this fix it?

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index defeb6035109..f53362efef84 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -771,10 +771,12 @@ unsigned long efi_main(efi_handle_t handle,
 			efi_err("Failed to load initrd!\n");
 			goto fail;
 		}
-		efi_set_u64_split(addr, &hdr->ramdisk_image,
-				  &boot_params->ext_ramdisk_image);
-		efi_set_u64_split(size, &hdr->ramdisk_size,
-				  &boot_params->ext_ramdisk_size);
+		if (size > 0) {
+			efi_set_u64_split(addr, &hdr->ramdisk_image,
+					  &boot_params->ext_ramdisk_image);
+			efi_set_u64_split(size, &hdr->ramdisk_size,
+					  &boot_params->ext_ramdisk_size);
+		}
 	}
 
 	/*

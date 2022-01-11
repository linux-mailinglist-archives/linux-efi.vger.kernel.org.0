Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04D148A5A0
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 03:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244339AbiAKC0h (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jan 2022 21:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244334AbiAKC0h (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jan 2022 21:26:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF56C06173F;
        Mon, 10 Jan 2022 18:26:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1EB1614AD;
        Tue, 11 Jan 2022 02:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82B3C36AE9;
        Tue, 11 Jan 2022 02:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641867996;
        bh=RoS5hZ6L8a7Wi1YOqt08vug9u+dcIkraLKLNW7lPZyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hGXMcP2jIxMqnKzLok7ha4kWfvc5Rn2CklJr5NMTvSnju9j2IVpr0s3UY9kmjx/Wj
         igkhJsD2G2a9H2i9Txe0DxBx1E3hY8Xy+nqWaGErttm1KA60a+jqtHynRQskQFvHOb
         4B75DYifrZMFgiUPw3KIcPU00DD6v7W4tC7LTDYEDNREsH6CFf59B0lTswyE+/5Pb1
         5bVIexCXR45V+8RLk7HYMJej339BOxU7FDcWUi99cvbm6PfbFFsFi2Lb5M1AQsg5Vh
         m7lP3sgoVgKujmGN5JbsFhrSImk6vTXjM3UltGLh3R4LRILqL3LGnOI8DQuXl3nQ8w
         xOepiqJCnLvDQ==
Date:   Tue, 11 Jan 2022 04:26:25 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>, dhowells@redhat.com,
        dwmw2@infradead.org, ardb@kernel.org, jmorris@namei.org,
        serge@hallyn.com, nayna@linux.ibm.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v9 8/8] integrity: Only use machine keyring when
 uefi_check_trust_mok_keys is true
Message-ID: <Ydzq0d+TzMmtohsV@iki.fi>
References: <20220105235012.2497118-1-eric.snowberg@oracle.com>
 <20220105235012.2497118-9-eric.snowberg@oracle.com>
 <YdoQbKD/jJompy6I@iki.fi>
 <2aa9e4b290424c869afe983ed63b5a0c4d12df36.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aa9e4b290424c869afe983ed63b5a0c4d12df36.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Jan 08, 2022 at 08:47:21PM -0500, Mimi Zohar wrote:
> On Sun, 2022-01-09 at 00:30 +0200, Jarkko Sakkinen wrote:
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > Mimi, have you tested these patches already?
> 
> Sorry, not yet this version this of the patch set.  Planning to test
> shortly.
> 
> Mimi
> 

Yeah, it is otherwise good IMHO. It's too late for v5.17 tho, so there is
no rush. We will get this to v5.18.

/Jarkko

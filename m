Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789E2231303
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jul 2020 21:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbgG1TpB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jul 2020 15:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732973AbgG1Tox (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jul 2020 15:44:53 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84FEC0619D5
        for <linux-efi@vger.kernel.org>; Tue, 28 Jul 2020 12:44:52 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d1so10503243plr.8
        for <linux-efi@vger.kernel.org>; Tue, 28 Jul 2020 12:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NjjWAW6FgXIfls/hqkrF/yquAYJxvalgxXMqC5yfkB8=;
        b=KIalYCFnh0ooJeOFJkJKg6Aj3ezi1dT2pKr43ERudEvFuNaAJ3+4031cCKI/mpqsHN
         jPODHusawyatNlhEIpveO4bRm2Qv8DouYUrTDu4x7sAqumvD4p0DaIwI9w47ua+Y+Lm8
         r5WIEN2ftI2xGaXzPY44IJT2WhYYdppfLz2ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NjjWAW6FgXIfls/hqkrF/yquAYJxvalgxXMqC5yfkB8=;
        b=hIfTtaelZrqR0IoaecaAPMcbkqdnFwW62oLvJulsWmnoaw1zi6jt/Icd52UzYbUyGY
         XAs3akKXbnqqEAdvdmrnSAuDGpUqD4o7HDmVdPV5wNbGCtmDIjXYYj60kxFrI7dvqPPK
         3PXMF6DqFqbREuBdq/5hQqp/Hn1RIWP579nnBCtLhMMkRey4vl23rBw0oHEKeMslVgZ0
         QSeIP4n978JuYz2KBmCfrO8TIQ/Mf+k4Z8luHApmSSKqH0IxwreGHQdgy4qwGEbhXj0Q
         CWOaLQYZQgAlC3chrIjIgJlywM5BlpQnmWMNeHEt23F8BM33FL9vmOsxgdbycfxyGU5c
         AXxQ==
X-Gm-Message-State: AOAM53042iG0pF+KlIOebfGAGNVoK9LQRCRzJolyv5m/N89V0PAPtoNb
        IN0vw87h81fksj2x2ZU0Tu008Q==
X-Google-Smtp-Source: ABdhPJzQr9cHayJZPGpWZHni51wQdtSr2aAnxIAMHwScc+g9u8gX4TqJT/xfpoMOHtZMCRUO5O3P+A==
X-Received: by 2002:a17:902:7446:: with SMTP id e6mr7253416plt.267.1595965492443;
        Tue, 28 Jul 2020 12:44:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m31sm4012561pjb.52.2020.07.28.12.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:44:51 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:44:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/19] IMA: Add support for file reads without contents
Message-ID: <202007281244.2F2681AE9@keescook>
References: <20200724213640.389191-1-keescook@chromium.org>
 <20200724213640.389191-16-keescook@chromium.org>
 <1595856214.4841.86.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1595856214.4841.86.camel@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jul 27, 2020 at 09:23:34AM -0400, Mimi Zohar wrote:
> On Fri, 2020-07-24 at 14:36 -0700, Kees Cook wrote:
> > From: Scott Branden <scott.branden@broadcom.com>
> > 
> > When the kernel_read_file LSM hook is called with contents=false, IMA
> > can appraise the file directly, without requiring a filled buffer. When
> > such a buffer is available, though, IMA can continue to use it instead
> > of forcing a double read here.
> > 
> > Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> > Link: https://lore.kernel.org/lkml/20200706232309.12010-10-scott.branden@broadcom.com/
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> After adjusting the comment below.
> 
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Sure!

Greg, shall I send a v4 with added Reviews and the comment change or is
that minor enough that you're able to do it?

Thanks for the reviews Mimi!

-Kees

> 
> > ---
> >  security/integrity/ima/ima_main.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> > 
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index dc4f90660aa6..459e50526a12 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -613,11 +613,8 @@ void ima_post_path_mknod(struct dentry *dentry)
> >  int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
> >  		  bool contents)
> >  {
> > -	/* Reject all partial reads during appraisal. */
> > -	if (!contents) {
> > -		if (ima_appraise & IMA_APPRAISE_ENFORCE)
> > -			return -EACCES;
> > -	}
> > +	enum ima_hooks func;
> > +	u32 secid;
> >  
> >  	/*
> >  	 * Do devices using pre-allocated memory run the risk of the
> > @@ -626,7 +623,20 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
> >  	 * buffers? It may be desirable to include the buffer address
> >  	 * in this API and walk all the dma_map_single() mappings to check.
> >  	 */
> > -	return 0;
> > +
> > +	/*
> > +	 * There will be a call made to ima_post_read_file() with
> > +	 * a filled buffer, so we don't need to perform an extra
> > +	 * read early here.
> > +	 */
> > +	if (contents)
> > +		return 0;
> > +
> > +	/* Read entire file for all partial reads during appraisal. */
> 
> In addition to verifying the file signature, the file might be
> included in the IMA measurement list or the file hash may be used to
> augment the audit record.  Please remove "during appraisal" from the
> comment.
> 
> > +	func = read_idmap[read_id] ?: FILE_CHECK;
> > +	security_task_getsecid(current, &secid);
> > +	return process_measurement(file, current_cred(), secid, NULL,
> > +				   0, MAY_READ, func);
> >  }
> >  
> >  const int read_idmap[READING_MAX_ID] = {
> 

-- 
Kees Cook

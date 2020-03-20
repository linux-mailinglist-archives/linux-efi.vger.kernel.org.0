Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4F018D63F
	for <lists+linux-efi@lfdr.de>; Fri, 20 Mar 2020 18:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgCTRvL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Mar 2020 13:51:11 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39552 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgCTRvL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Mar 2020 13:51:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id t17so7751172qkm.6;
        Fri, 20 Mar 2020 10:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hxHH0kI7s1vSpVNgl5JYOWg+jijYanmSy/fK/k59mT8=;
        b=bOREPh6B9ekSJA6CE6WbUoN4PEKqt+XZgcxLZUZqrwE/Qf1daE1U/j9xt2w6ebgFp0
         0M46nVb/5VZLl5ExIYy0TMgkyox0HTEbDTQSIBZCpdYaJ6jP3tHgifgOvuLCjW+77yZQ
         HnVt1OCNXk/KQH6VrM57fFVIKLQh4lpuGPLVwOIYYIp/lYlYiojoURwfVNHHy3kesBV2
         Rm6hrK6GnvFkoHuI7zO//Ar+i2JwvXVtFySdI3FOMdJ5QtIJxQW4bGmdGBTXkAcHTv4S
         xQ4cfh+InlKtIFTLEQx/ptuKpAzPmebKwdlnkEFg9dNKwZsSmTxJxSm9PsJSjC9KceP/
         +0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hxHH0kI7s1vSpVNgl5JYOWg+jijYanmSy/fK/k59mT8=;
        b=sNsqfBisxENwUj/HIfRt6hhZEGaDxZNmQxPD53id+kmZDS2ZOoxJqYItKaFkqieFCO
         sj/t0x2Csdo6cs8giFgqO1k8ZVVncovlOj4gR4q8y/CDu9E+fdK19/ap/yA0kmBj6hCh
         S5/w8oILKgqJ96Tpg/rquWd6Gpkys1X4fJnpS9h5HoSRWqps7v8ZaMO36OJWI30BoGnZ
         IxHDsDG9mTpTu9fLR1Bkve0d/uuH26N0udgowZPkCHV1nE3mje9zAmkr+e7fTAIPNaNM
         j7ovnj4VIPl9hy4hmr5MYOoHDtfyvSm4GLX+RX8NGD37FXp42Kx6uuC0sTma5qbPzrtI
         LRXA==
X-Gm-Message-State: ANhLgQ3bsL4zhcIxL3ZDmPRkPmeBQTceglFtYrnbZwwxAB8gr9It6b/F
        rHuddUOFAUpxQFad1fhKQ1k=
X-Google-Smtp-Source: ADFU+vtfxAY9dL7Q7kXhNYv31rCod+UHnzHqE+xyavb3dEcZvHd+VebFGeabrnJckiMgwi3q1ojrLw==
X-Received: by 2002:a37:9104:: with SMTP id t4mr9634724qkd.449.1584726669509;
        Fri, 20 Mar 2020 10:51:09 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z1sm5136726qtc.51.2020.03.20.10.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 10:51:09 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 20 Mar 2020 13:51:07 -0400
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Arvind Sankar <nivedita@alum.mit.edu>,
        kbuild-all@lists.01.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/14] efi/gop: Allow specifying mode number on command
 line
Message-ID: <20200320175104.GA3101477@rani.riverdale.lan>
References: <20200319192855.29876-12-nivedita@alum.mit.edu>
 <20200320143526.GI4650@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200320143526.GI4650@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Mar 20, 2020 at 05:36:04PM +0300, Dan Carpenter wrote:
> Hi Arvind,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> url:    https://github.com/0day-ci/linux/commits/Arvind-Sankar/efi-gop-Refactoring-mode-setting-feature/20200320-044605
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> drivers/firmware/efi/libstub/gop.c:113 set_mode() error: uninitialized symbol 'new_mode'.
> 
> # https://github.com/0day-ci/linux/commit/af85e496c9f577df9743784171b1cda94220dd8f
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout af85e496c9f577df9743784171b1cda94220dd8f
> vim +/info +85 drivers/firmware/efi/libstub/gop.c
> 
> af85e496c9f577 Arvind Sankar 2020-03-19   97  static void set_mode(efi_graphics_output_protocol_t *gop)
> af85e496c9f577 Arvind Sankar 2020-03-19   98  {
> af85e496c9f577 Arvind Sankar 2020-03-19   99  	efi_graphics_output_protocol_mode_t *mode;
> af85e496c9f577 Arvind Sankar 2020-03-19  100  	u32 cur_mode, new_mode;
> af85e496c9f577 Arvind Sankar 2020-03-19  101  
> af85e496c9f577 Arvind Sankar 2020-03-19  102  	switch (cmdline.option) {
> af85e496c9f577 Arvind Sankar 2020-03-19  103  	case EFI_CMDLINE_NONE:
> af85e496c9f577 Arvind Sankar 2020-03-19  104  		return;
> af85e496c9f577 Arvind Sankar 2020-03-19  105  	case EFI_CMDLINE_MODE_NUM:
> af85e496c9f577 Arvind Sankar 2020-03-19  106  		new_mode = choose_mode_modenum(gop);
> af85e496c9f577 Arvind Sankar 2020-03-19  107  		break;
> 
> No default case?

Yeah, it's an enum with the only two values covered by the switch cases,
so it's really a bogus warning. I posted a v2 with a default case
instead anyway to silence it.

> 
> af85e496c9f577 Arvind Sankar 2020-03-19  108  	}
> af85e496c9f577 Arvind Sankar 2020-03-19  109  
> af85e496c9f577 Arvind Sankar 2020-03-19  110  	mode = efi_table_attr(gop, mode);
> af85e496c9f577 Arvind Sankar 2020-03-19  111  	cur_mode = efi_table_attr(mode, mode);
> af85e496c9f577 Arvind Sankar 2020-03-19  112  
> af85e496c9f577 Arvind Sankar 2020-03-19 @113  	if (new_mode == cur_mode)
> af85e496c9f577 Arvind Sankar 2020-03-19  114  		return;
> af85e496c9f577 Arvind Sankar 2020-03-19  115  
> af85e496c9f577 Arvind Sankar 2020-03-19  116  	if (efi_call_proto(gop, set_mode, new_mode) != EFI_SUCCESS)
> af85e496c9f577 Arvind Sankar 2020-03-19  117  		efi_printk("Failed to set requested mode\n");
> af85e496c9f577 Arvind Sankar 2020-03-19  118  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

